{-# LANGUAGE OverloadedStrings #-}

module Leankit.Types where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson

import Data.ByteString.Lazy (ByteString)

data Reply datatype = Reply {
        _replyCode :: Int,
        _replyText :: String,
        _replyData :: [Maybe datatype]
} deriving (Eq, Show)

instance FromJSON datatype => FromJSON (Reply datatype) where
        parseJSON (Object v) = Reply 
                               <$> v .: "ReplyCode" 
                               <*> v .: "ReplyText"
                               <*> v .: "ReplyData"
        parseJSON _          = mzero

parseReply :: FromJSON a => ByteString -> Either String (Reply a)
parseReply = eitherDecode

parseReplyData :: FromJSON a => ByteString -> Either String a
parseReplyData json_ = 
	case reply of
		Left s     -> Left s
		Right repl -> case _replyData repl of
						[]              -> Left  $ errorMsg repl
						(Nothing:[])    -> Left  $ errorMsg repl
						(Just rdata:[]) -> Right   rdata
						_               -> Left  $ errorMsg repl ++ " (multiple items in result data)"
	where 
		reply = parseReply json_
		errorMsg repl = show (_replyCode repl) ++ ": " ++ _replyText repl
