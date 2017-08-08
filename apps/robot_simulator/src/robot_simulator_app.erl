%%%-------------------------------------------------------------------
%% @doc robot_simulator public API
%% @end
%%%-------------------------------------------------------------------

-module(robot_simulator_app).

%%-behaviour(application).

%% Application callbacks
-export([initialize/2,control/2,change_dir/2,change_right/1]).

%%====================================================================
%% API
%%====================================================================

%%start(_StartType, _StartArgs) ->
%%    robot_simulator_sup:start_link().

%%--------------------------------------------------------------------
%%stop(_State) ->
%%    ok.

%%====================================================================
%% Internal functions
%%====================================================================

initialize(Coordinate,Direction)->
    {Coordinate,Direction}.

control(Robotpos,[])->
    Robotpos;
control(Robotpos,[H|T])->
    New_pos = apply_command(H,Robotpos),
    control(New_pos,T).

apply_command(Move,Robotpos) when Move == $r orelse Move == $l ->
    {{X,Y}, Dir} = Robotpos,
    {{X,Y}, change_dir(Move,Dir)};
apply_command(Move,Robotpos) when Move == $f orelse Move == $b ->
    {{X,Y}, Dir} = Robotpos,
    change_coord(Move,{X,Y},Dir).


change_dir(Mov,Dir)->
    case Mov of
        $r ->
            change_right(Dir);
        $l ->
            change_left(Dir)
    end.


change_right(Dir)->
    case Dir of 
        north ->
            east;
        east ->
            south;
        south->
            west;
        west ->
            north
    end.

change_left(Dir)->
    case Dir of
        north ->
            west;
        west ->
            south;
        south ->
            east;
        east ->
            north
    end.
               

change_coord(H,{X,Y},Dir)->
    case H of
        $f ->
            move_forward({X,Y},Dir);
        $b ->
            move_backward({X,Y},Dir)
    end.
        

move_forward({X,Y},Dir)->
    case Dir of
        north ->
            {{X,Y+1},north};
        east ->
            {{X+1,Y},east};
        south ->
            {{X,Y-1},south};
        west ->
            {{X-1,Y},west}
    end.

move_backward({X,Y},Dir)->
    case Dir of
        north ->
            {{X,Y-1},north};
        east ->
            {{X-1,Y},east};
        south ->
            {{X,Y+1},south};
        west ->
            {{X+1,Y},west}
    end.


    
