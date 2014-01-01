module Leankit.Api where

import Data.ByteString.Lazy.Internal (ByteString)
import Network.Curl

import Control.Applicative ((<$>))

import Data.Aeson
import Leankit.Types
import Leankit.Types.Common
import Leankit.Types.Credentials
import Leankit.Types.Board (Board)
import Leankit.Types.BoardShort (BoardShort)
import Leankit.Types.Card (Card)
import Leankit.Types.BoardIdentifierSet (BoardIdentifierSet)
import Leankit.Types.BoardHistoryItem (BoardHistoryItem)
import Leankit.Types.Lane (Lane)
import Leankit.Types.LaneLayout (LaneLayout)
import Leankit.Types.CardHistoryItem (CardHistoryItem)
import Leankit.Types.CardComment (CardComment)

-- TODO what can we do with this?
(<=<) :: Monad m => (b->m c) -> (a -> m b) -> a -> m c
(<=<) fbc fab a = fbc =<< fab a

(<==<) :: Monad m => (b->m c) -> (a1 -> a2 -> m b) -> a1 -> a2 -> m c
(<==<) fbc fab a1 a2 = fbc =<< fab a1 a2

(<===<) :: Monad m => (b->m c) -> (a1 -> a2 -> a3 -> m b) -> a1 -> a2 -> a3 -> m c
(<===<) fbc fab a1 a2 a3 = fbc =<< fab a1 a2 a3

---------
-- API --
---------

-- getBoards
getBoards :: Credentials -> IO [BoardShort]
getBoards = _either2fail <=< getBoardsEither

getBoardsMaybe :: Credentials -> IO (Maybe [BoardShort])
getBoardsMaybe = _either2maybe <=< getBoardsEither

getBoardsEither :: Credentials -> IO (Either String [BoardShort])
getBoardsEither creds = _apiCallEither creds "/Boards/"


-- getBoard
getBoard :: Credentials -> BoardID -> IO Board
getBoard = _either2fail <==< getBoardEither

getBoardMaybe :: Credentials -> BoardID -> IO (Maybe Board)
getBoardMaybe = _either2maybe <==< getBoardEither

getBoardEither :: Credentials -> BoardID -> IO (Either String Board)
getBoardEither cred (BoardID boardID) = _apiCallEither cred ("/Boards/" ++ show boardID)


-- getCard
getCard :: Credentials -> BoardID -> CardID -> IO Card
getCard = _either2fail <===< getCardEither

getCardMaybe :: Credentials -> BoardID -> CardID -> IO (Maybe Card)
getCardMaybe = _either2maybe <===< getCardEither

getCardEither :: Credentials -> BoardID -> CardID -> IO (Either String Card)
getCardEither cred boardID (CardID cardID) = _boardApiCallEither cred boardID ("/GetCard/" ++ show cardID ++ "/")


-- getBoardIdentifiers
getBoardIdentifiers :: Credentials -> BoardID -> IO BoardIdentifierSet
getBoardIdentifiers = _either2fail <==< getBoardIdentifiersEither

getBoardIdentifiersMaybe :: Credentials -> BoardID -> IO (Maybe BoardIdentifierSet)
getBoardIdentifiersMaybe = _either2maybe <==< getBoardIdentifiersEither

getBoardIdentifiersEither :: Credentials -> BoardID -> IO (Either String BoardIdentifierSet)
getBoardIdentifiersEither cred boardID = _boardApiCallEither cred boardID "/GetBoardIdentifiers/"


-- getNewerIfExists
-- NOTE that this function returns with Nothing not only when an error occures
--      but when there is no newer board than the given version.
--      This is why ``getNewerIfExists`` returns with ``Maybe Board`` already.
getNewerIfExists :: Credentials -> BoardID -> Int -> IO (Maybe Board)
getNewerIfExists = getNewerIfExistsMaybe

getNewerIfExistsMaybe :: Credentials -> BoardID -> Int -> IO (Maybe Board)
getNewerIfExistsMaybe = _either2maybe <===< getNewerIfExistsEither

getNewerIfExistsEither :: Credentials -> BoardID -> Int -> IO (Either String Board)
getNewerIfExistsEither cred boardID boardVersion = 
	_boardApiCallEither cred boardID ("/BoardVersion/" ++ show boardVersion ++ "/GetNewerIfExists/")


-- getBoardHistorySince
getBoardHistorySince :: Credentials -> BoardID -> Int -> IO [BoardHistoryItem]
getBoardHistorySince = _either2fail <===< getBoardHistorySinceEither

getBoardHistorySinceMaybe :: Credentials -> BoardID -> Int -> IO (Maybe [BoardHistoryItem])
getBoardHistorySinceMaybe = _either2maybe <===< getBoardHistorySinceEither

getBoardHistorySinceEither :: Credentials -> BoardID -> Int -> IO (Either String [BoardHistoryItem])
getBoardHistorySinceEither cred boardID boardVersion =
	_boardApiCallEither cred boardID ("/BoardVersion/" ++ show boardVersion ++ "/GetBoardHistorySince/")


-- getCardByExternalId
getCardByExternalId :: Credentials -> BoardID -> String -> IO Card
getCardByExternalId = _either2fail <===< getCardByExternalIdEither

getCardByExternalIdMaybe :: Credentials -> BoardID -> String -> IO (Maybe Card)
getCardByExternalIdMaybe = _either2maybe <===< getCardByExternalIdEither

getCardByExternalIdEither :: Credentials -> BoardID -> String -> IO (Either String Card)
getCardByExternalIdEither cred boardID externalID = _boardApiCallEither cred boardID ("/GetCardByExternalId/" ++ show externalID ++ "/")


-- getBackLog
getBackLog :: Credentials -> BoardID -> IO [Lane]
getBackLog = _either2fail <==< getBackLogEither

getBackLogMaybe :: Credentials -> BoardID -> IO (Maybe [Lane])
getBackLogMaybe = _either2maybe <==< getBackLogEither

getBackLogEither :: Credentials -> BoardID -> IO (Either String [Lane])
getBackLogEither cred boardID = _boardApiCallEither cred boardID "/Backlog/"


-- getArchive
getArchive :: Credentials -> BoardID -> IO [LaneLayout]
getArchive = _either2fail <==< getArchiveEither

getArchiveMaybe :: Credentials -> BoardID -> IO (Maybe [LaneLayout])
getArchiveMaybe = _either2maybe <==< getArchiveEither

getArchiveEither :: Credentials -> BoardID -> IO (Either String [LaneLayout])
getArchiveEither cred boardID = _boardApiCallEither cred boardID "/Archive/"


-- getCardHistory
getCardHistory :: Credentials -> BoardID -> CardID -> IO [CardHistoryItem]
getCardHistory = _either2fail <===< getCardHistoryEither

getCardHistoryMaybe :: Credentials -> BoardID -> CardID -> IO (Maybe [CardHistoryItem])
getCardHistoryMaybe = _either2maybe <===< getCardHistoryEither

getCardHistoryEither :: Credentials -> BoardID -> CardID -> IO (Either String [CardHistoryItem])
getCardHistoryEither cred (BoardID boardID) (CardID cardID) = 
	_apiCallEither cred ("/Card/History/" ++ show boardID ++ "/" ++ show cardID ++ "/")


-- getCardComments
getCardComments :: Credentials -> BoardID -> CardID -> IO [CardComment]
getCardComments = _either2fail <===< getCardCommentsEither

getCardCommentsMaybe :: Credentials -> BoardID -> CardID -> IO (Maybe [CardComment])
getCardCommentsMaybe = _either2maybe <===< getCardCommentsEither

getCardCommentsEither :: Credentials -> BoardID -> CardID -> IO (Either String [CardComment])
getCardCommentsEither cred (BoardID boardID) (CardID cardID) = 
	_apiCallEither cred ("/Card/GetComments/" ++ show boardID ++ "/" ++ show cardID ++ "/")


-------------
-- PRIVATE --
-------------

_either2fail :: FromJSON a => Either String a -> IO a
_either2fail (Left err) = fail err
_either2fail (Right res) = return res

_either2maybe :: FromJSON a => Either String a -> IO (Maybe a)
_either2maybe (Left _) = return Nothing
_either2maybe (Right res) = return $ Just res

_boardApiCallEither :: FromJSON a => Credentials -> BoardID -> String -> IO (Either String a)
_boardApiCallEither cred (BoardID boardID) urlfrag = 
	_apiCallEither cred ("/Board/" ++ show boardID ++ urlfrag) 
	
_apiCallEither :: FromJSON a => Credentials -> String -> IO (Either String a)
_apiCallEither creds url = parseReplyData <$> _loadPath url creds

_loadPath :: String -> Credentials -> IO ByteString
_loadPath lpath cred = do
        (_, body) <- curlGetString_ url opts
        return body
    where
        url = "http://" ++ _company cred ++ ".leankitkanban.com/Kanban/Api" ++ lpath
        opts = [CurlUserPwd authstr]
        authstr = _username cred ++ ":" ++ _password cred
