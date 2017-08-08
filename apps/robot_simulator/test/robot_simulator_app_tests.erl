-module(robot_simulator_app_tests).
-include_lib("eunit/include/eunit.hrl").

initialize_test()->
    {{5,2},north} = robot_simulator_app:initialize({5,2},north).

change_right_test()->
    ?assertEqual(east,robot_simulator_app:change_dir($r,north)),
    ?assertEqual(south,robot_simulator_app:change_dir($r,east)),
    ?assertEqual(west,robot_simulator_app:change_dir($r,south)),
    ?assertEqual(north,robot_simulator_app:change_dir($r,west)).

change_left_test()->
    ?assertEqual(west,robot_simulator_app:change_dir($l,north)),
    ?assertEqual(north,robot_simulator_app:change_dir($l,east)),
    ?assertEqual(east,robot_simulator_app:change_dir($l,south)),
    ?assertEqual(south,robot_simulator_app:change_dir($l,west)).

control_right_test()->
    Robot = robot_simulator_app:initialize({5,2},north),
    ?assertEqual({{5,2},east},robot_simulator_app:control(Robot,"r")).


control_left_test()->
    Robot = robot_simulator_app:initialize({5,2},north),
    ?assertEqual({{5,2},west},robot_simulator_app:control(Robot,"l")).

control_forward_test()->
    Robot = robot_simulator_app:initialize({5,2},north),
    ?assertEqual({{5,3},north},robot_simulator_app:control(Robot,"f")).

control_backward_test()->
    Robot = robot_simulator_app:initialize({5,2},north),
    ?assertEqual({{5,1},north},robot_simulator_app:control(Robot,"b")).


control_complex_movement_test()->
    Robot = robot_simulator_app:initialize({7,3},north),
    ?assertEqual({{10,4},west},robot_simulator_app:control(Robot,"rfflflb")),
    Robot2 = robot_simulator_app:initialize({0,0},north),
    ?assertEqual({{5,5},east},robot_simulator_app:control(Robot2,"fffffrfffff")),
    Robot3 = robot_simulator_app:initialize({0,0},north),
    ?assertEqual({{0,0},north},robot_simulator_app:control(Robot3,"fffffrfffffbbbbblbbbbb")).
