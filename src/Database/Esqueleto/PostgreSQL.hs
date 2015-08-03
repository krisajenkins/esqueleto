{-# LANGUAGE OverloadedStrings
 #-}
-- | This module contain PostgreSQL-specific functions.
--
-- /Since: 2.2.8/
module Database.Esqueleto.PostgreSQL
  ( arrayAgg
  , stringAgg
  , chr
  , regexpReplace
  ) where

import Data.String (IsString)

import Database.Esqueleto.Internal.Language
import Database.Esqueleto.Internal.Sql


-- | (@array_agg@) Concatenate input values, including @NULL@s,
-- into an array.
--
-- /Since: 2.2.8/
arrayAgg :: SqlExpr (Value a) -> SqlExpr (Value [a])
arrayAgg = unsafeSqlFunction "array_agg"


-- | (@string_agg@) Concatenate input values separated by a
-- delimiter.
--
-- /Since: 2.2.8/
stringAgg
  :: IsString s
  => SqlExpr (Value s) -- ^ Input values.
  -> SqlExpr (Value s) -- ^ Delimiter.
  -> SqlExpr (Value s) -- ^ Concatenation.
stringAgg expr delim = unsafeSqlFunction "string_agg" (expr, delim)


-- | (@chr@) Translate the given integer to a character. (Note the result will
-- depend on the character set of your database.)
--
-- /Since: 2.2.11/
chr :: IsString s
    => SqlExpr (Value Int) -> SqlExpr (Value s)
chr = unsafeSqlFunction "chr"

-- | (@regexpReplace@) Replace substring(s) matching a POSIX regular expression.
--
-- /Since: 2.2.12/
regexpReplace :: (IsString s)
              => SqlExpr (Value s)
              -> SqlExpr (Value s)
              -> SqlExpr (Value s)
              -> SqlExpr (Value s)
              -> SqlExpr (Value s)
regexpReplace string pattern replacement flags =
  unsafeSqlFunction "regexp_replace"
                    (string,pattern,replacement,flags)
