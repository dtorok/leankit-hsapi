module Leankit.Types.TH where

import Data.Char
import Data.Aeson.Types


key2field :: String -> String
key2field [] = []
key2field "_wip" = "WIP"
key2field ('_':x:xs) = ((toUpper x) : xs)
key2field fn = undefined -- fail $ "Invalid fieldname" ++ fn

parseOptions = defaultOptions{fieldLabelModifier=key2field}
