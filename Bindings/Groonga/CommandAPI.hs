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
import Control.Monad.Trans.Resource (allocate, release, runResourceT)
import Control.Monad.Trans.Class (lift)

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

grn_database_open :: Ptr C'_grn_ctx -> Database -> IO (Ptr C'_grn_obj)
grn_database_open ctx dbpath = do
  dbname <- newCAString dbpath
  db <- c'grn_db_open ctx dbname
  return db

grn_database_create :: Ptr C'_grn_ctx -> Database -> IO (Ptr C'_grn_obj)
grn_database_create ctx dbpath = do
  dbname <- newCAString dbpath
  db <- c'grn_db_create ctx dbname nullPtr
  return db

grn_execute_command :: Ptr C'_grn_ctx -> Command -> IO String
grn_execute_command ctx command = runResourceT $ do
  let command_len = length command
      flag        = 0
  ccommand <- lift $ newCAString command
  _ <- lift $ c'grn_ctx_send ctx ccommand (fromIntegral command_len) flag
  (res_key,received_res)   <- allocate (malloc :: IO (Ptr CString)) free
  (len_key,received_len)   <- allocate (malloc :: IO (Ptr CUInt)) free
  (flag_key,received_flag) <- allocate (malloc :: IO (Ptr CInt)) free
  _ <- lift $ c'grn_ctx_recv ctx received_res received_len received_flag
  res_cstr <- lift $ peek received_res
  res_str  <- lift $ peekCString res_cstr
  lift $ mapM_ release [res_key, len_key, flag_key]
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
