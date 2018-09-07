module Views.Body exposing (..)

import Views.TemplateView as TemplateView
import Views.ResourcesView as ResourcesView
import Models.Resources.Instance exposing (Instance, InstanceId)
import Models.Resources.InstanceTasks exposing (InstanceTasks)
import Models.Resources.Role exposing (Role)
import Models.Resources.NodeResources exposing (NodeResources)
import Models.Resources.Template exposing (TemplateId, Template, addTemplateInstanceString)
import Models.Ui.BodyUiModel exposing (BodyUiModel, TemporaryStates)
import Updates.Messages exposing (UpdateBodyViewMsg(..))
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.Utilities.Spacing as Spacing
import Array exposing (Array)
import Messages exposing (..)


view : Dict TemplateId Template -> Dict InstanceId Instance -> Dict InstanceId InstanceTasks -> BodyUiModel -> Maybe Role -> Html UpdateBodyViewMsg
view templates instances tasks bodyUiModel maybeRole =
    Grid.container
        [ Spacing.mt3 ]
        (templates
            |> Dict.values
            |> List.map (TemplateView.view instances tasks templates bodyUiModel maybeRole)
        )


resourcesView : TemporaryStates -> List NodeResources -> Html AnyMsg
resourcesView temporaryStates nodesResources =
    Grid.container
        [ Spacing.mt5 ]
        (List.concat
            [ ResourcesView.headerView
            , List.concat
                (nodesResources
                    |> List.map (ResourcesView.view temporaryStates)
                )
            ]
        )
