module Bindings.Groonga.CommandAPI
  ( grn_ctx_init
  , grn_ctx_fin
  , grn_database_open
  , grn_database_create
  , grn_execute_command
  , grn_get_errbuf
  , grn_get_version
  , module Bindings.Groonga.Types ) where
import Bindings.Groonga
import Bindings.Groonga.Types
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr
import Foreign.Marshal.Alloc
import Foreign.Storable

grn_ctx_init :: IO (Ptr C'_grn_ctx)
grn_ctx_init = do
  rc <- c'grn_init
  ctx <- c'grn_ctx_open rc
  return ctx

grn_ctx_fin :: Ptr C'_grn_ctx -> IO C'grn_rc
grn_ctx_fin ctx = do
  _ <- c'grn_ctx_fin ctx
  rc <- c'grn_fin
  return rc

grn_database_open :: Ptr C'_grn_ctx -> String -> IO (Ptr C'_grn_obj)
grn_database_open ctx dbpath = do
  dbname <- newCAString dbpath
  db <- c'grn_db_open ctx dbname
  return db

grn_database_create :: Ptr C'_grn_ctx -> String -> IO (Ptr C'_grn_obj)
grn_database_create ctx dbpath = do
  dbname <- newCAString dbpath
  db <- c'grn_db_create ctx dbname nullPtr
  return db

grn_execute_command :: Ptr C'_grn_ctx -> Command -> IO String
grn_execute_command ctx command = do
  let command_len = length command
      flag        = 0
  ccommand <- newCAString command
  _ <- c'grn_ctx_send ctx ccommand (fromIntegral command_len) flag
  received_res  <- malloc :: IO (Ptr CString)
  received_len  <- malloc :: IO (Ptr CUInt)
  received_flag <- malloc :: IO (Ptr CInt)
  _ <- c'grn_ctx_recv ctx received_res received_len received_flag
  res_cstr <- peek received_res
  res_str  <- peekCString res_cstr
  free received_res
  free received_len
  free received_flag
  return res_str

grn_get_errbuf :: Ptr C'_grn_ctx -> IO String
grn_get_errbuf ctx = do
  let char = p'_grn_ctx'errbuf ctx
  errbuf <- peekCString char
  return errbuf

grn_get_version :: IO String
grn_get_version = do
  cversion <- c'grn_get_version
  version <- peekCString cversion
  return version
