{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <groonga/plugin.h>
module Bindings.Groonga.Raw.Plugin where
import Foreign.Ptr
#strict_import

import Bindings.Groonga.Raw
#ccall grn_plugin_impl_init , Ptr <struct _grn_ctx> -> IO <grn_rc>
#ccall grn_plugin_impl_register , Ptr <struct _grn_ctx> -> IO <grn_rc>
#ccall grn_plugin_impl_fin , Ptr <struct _grn_ctx> -> IO <grn_rc>
#ccall grn_plugin_malloc , Ptr <struct _grn_ctx> -> CSize -> CString -> CInt -> CString -> IO (Ptr ())
#ccall grn_plugin_realloc , Ptr <struct _grn_ctx> -> Ptr () -> CSize -> CString -> CInt -> CString -> IO (Ptr ())
#ccall grn_plugin_free , Ptr <struct _grn_ctx> -> Ptr () -> CString -> CInt -> CString -> IO ()
#ccall grn_plugin_set_error , Ptr <struct _grn_ctx> -> <grn_log_level> -> <grn_rc> -> CString -> CInt -> CString -> CString -> IO ()
#ccall grn_plugin_backtrace , Ptr <struct _grn_ctx> -> IO ()
#ccall grn_plugin_logtrace , Ptr <struct _grn_ctx> -> <grn_log_level> -> IO ()
{- typedef struct _grn_plugin_mutex grn_plugin_mutex; -}
#opaque_t struct _grn_plugin_mutex
#synonym_t grn_plugin_mutex , <struct _grn_plugin_mutex>
#ccall grn_plugin_mutex_open , Ptr <struct _grn_ctx> -> IO (Ptr <struct _grn_plugin_mutex>)
#ccall grn_plugin_mutex_create , Ptr <struct _grn_ctx> -> IO (Ptr <struct _grn_plugin_mutex>)
#ccall grn_plugin_mutex_close , Ptr <struct _grn_ctx> -> Ptr <struct _grn_plugin_mutex> -> IO ()
#ccall grn_plugin_mutex_destroy , Ptr <struct _grn_ctx> -> Ptr <struct _grn_plugin_mutex> -> IO ()
#ccall grn_plugin_mutex_lock , Ptr <struct _grn_ctx> -> Ptr <struct _grn_plugin_mutex> -> IO ()
#ccall grn_plugin_mutex_unlock , Ptr <struct _grn_ctx> -> Ptr <struct _grn_plugin_mutex> -> IO ()
#ccall grn_plugin_proc_alloc , Ptr <struct _grn_ctx> -> Ptr <grn_user_data> -> CUInt -> CUShort -> IO (Ptr <struct _grn_obj>)
#ccall grn_plugin_proc_get_var , Ptr <struct _grn_ctx> -> Ptr <grn_user_data> -> CString -> CInt -> IO (Ptr <struct _grn_obj>)
#ccall grn_plugin_proc_get_var_by_offset , Ptr <struct _grn_ctx> -> Ptr <grn_user_data> -> CUInt -> IO (Ptr <struct _grn_obj>)
#ccall grn_plugin_win32_base_dir , IO CString
#ccall grn_plugin_charlen , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CInt
#ccall grn_plugin_isspace , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CInt
