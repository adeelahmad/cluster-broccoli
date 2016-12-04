module Updates.UpdateLoginStatus exposing (updateLoginStatus)

import Updates.Messages exposing (UpdateLoginStatusMsg(..), UpdateLoginFormMsg(..))
import Messages exposing (AnyMsg(..))
import Models.Resources.UserInfo exposing (UserInfo)
import Utils.CmdUtils exposing (cmd)
import Debug

updateLoginStatus : UpdateLoginStatusMsg -> Maybe UserInfo -> (Maybe UserInfo, Cmd AnyMsg)
updateLoginStatus message oldLoginStatus =
  case message of
    FetchLogin (Ok loggedInUser) ->
      ( Just loggedInUser
      , Cmd.none
      )
    FetchLogin (Err error) ->
      ( oldLoginStatus
      , (cmd (UpdateLoginFormMsg FailedLoginAttempt))
      )