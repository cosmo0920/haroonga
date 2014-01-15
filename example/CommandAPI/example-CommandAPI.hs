import Bindings.Groonga
import Bindings.Groonga.CommandAPI

-- ref: example in http://qiita.com/groonga/items/71b145b37d77bd160bf2
main :: IO ()
main = do
  -- init context
  ctx <- grn_ctx_init
  let dbpath = "db/test.db"
  -- db create
  _ <- grn_database_create ctx dbpath
  -- send command
  let command = "table_create Users TABLE_HASH_KEY ShortText"
  _ <- grn_execute_command ctx command
  dump_res <- grn_execute_command ctx "dump"
  putStrLn dump_res
  errbuf <- grn_get_errbuf ctx
  putStrLn errbuf
  _ <- grn_ctx_fin ctx
  return ()
