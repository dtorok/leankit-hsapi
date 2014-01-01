module Leankit.Types.Credentials where

data Credentials = Credentials {
	_company :: String,
	_username :: String,
	_password :: String
}

instance Show Credentials where
	show cred = "Credentials " ++ _company cred ++ " " ++ _username cred ++ " *****"
