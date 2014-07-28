{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <groonga/tokenizer.h>
module Bindings.Groonga.Raw.Tokenizer where
import Foreign.Ptr
#strict_import

import Bindings.Groonga.Raw
import Bindings.Groonga.Raw.Plugin
#ccall grn_tokenizer_charlen , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CInt
#ccall grn_tokenizer_isspace , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CInt
#ccall grn_tokenizer_is_tokenized_delimiter , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CUChar
#ccall grn_tokenizer_have_tokenized_delimiter , Ptr <struct _grn_ctx> -> CString -> CUInt -> <grn_encoding> -> IO CUChar
{- typedef struct _grn_tokenizer_query grn_tokenizer_query; -}
#synonym_t grn_tokenizer_query , <struct _grn_tokenizer_query>
{- struct _grn_tokenizer_query {
    grn_obj * normalized_query;
    char * query_buf;
    const char * ptr;
    unsigned int length;
    grn_encoding encoding;
    unsigned int flags;
    grn_bool have_tokenized_delimiter;
}; -}
#starttype struct _grn_tokenizer_query
#field normalized_query , Ptr <struct _grn_obj>
#field query_buf , CString
#field ptr , CString
#field length , CUInt
#field encoding , <grn_encoding>
#field flags , CUInt
#field have_tokenized_delimiter , CUChar
#stoptype
#ccall grn_tokenizer_query_open , Ptr <struct _grn_ctx> -> CInt -> Ptr (Ptr <struct _grn_obj>) -> CUInt -> IO (Ptr <struct _grn_tokenizer_query>)
#ccall grn_tokenizer_query_create , Ptr <struct _grn_ctx> -> CInt -> Ptr (Ptr <struct _grn_obj>) -> IO (Ptr <struct _grn_tokenizer_query>)
#ccall grn_tokenizer_query_close , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_query> -> IO ()
#ccall grn_tokenizer_query_destroy , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_query> -> IO ()
{- typedef struct _grn_tokenizer_token grn_tokenizer_token; -}
#synonym_t grn_tokenizer_token , <struct _grn_tokenizer_token>
{- struct _grn_tokenizer_token {
    grn_obj str; grn_obj status;
}; -}
#starttype struct _grn_tokenizer_token
#field str , <struct _grn_obj>
#field status , <struct _grn_obj>
#stoptype
#ccall grn_tokenizer_token_init , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_token> -> IO ()
#ccall grn_tokenizer_token_fin , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_token> -> IO ()
{- typedef unsigned int grn_tokenizer_status; -}
#synonym_t grn_tokenizer_status , CUInt
#ccall grn_tokenizer_token_push , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_token> -> CString -> CUInt -> CUInt -> IO ()
#ccall grn_tokenizer_tokenized_delimiter_next , Ptr <struct _grn_ctx> -> Ptr <struct _grn_tokenizer_token> -> CString -> CUInt -> <grn_encoding> -> IO CString
#ccall grn_tokenizer_register , Ptr <struct _grn_ctx> -> CString -> CUInt -> Ptr <grn_proc_func> -> Ptr <grn_proc_func> -> Ptr <grn_proc_func> -> IO <grn_rc>
