%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2013-2014. All Rights Reserved.
%%
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%%
%% %CopyrightEnd%
-module(cdv_sched_cb).

-export([col_to_elem/1,
	 col_spec/0,
	 get_info/1,
	 get_details/2,
	 get_detail_cols/1,
	 detail_pages/0
	]).

-include_lib("wx/include/wx.hrl").
-include("crashdump_viewer.hrl").

%% Columns
-define(COL_ID,  0).
-define(COL_PROC,  ?COL_ID+1).
-define(COL_PORT,  ?COL_PROC+1).
-define(COL_RQL,   ?COL_PORT+1).
-define(COL_PQL,   ?COL_RQL+1).

%% Callbacks for cdv_virtual_list_wx
col_to_elem(id) -> col_to_elem(?COL_ID);
col_to_elem(?COL_ID)  -> #sched.name;
col_to_elem(?COL_PROC)  -> #sched.process;
col_to_elem(?COL_PORT)  -> #sched.port;
col_to_elem(?COL_RQL)   -> #sched.run_q;
col_to_elem(?COL_PQL)   -> #sched.port_q.

col_spec() ->
    [{"Id",                ?wxLIST_FORMAT_RIGHT,   50},
     {"Current Process",   ?wxLIST_FORMAT_CENTER, 130},
     {"Current Port",      ?wxLIST_FORMAT_CENTER, 130},
     {"Run Queue Length",  ?wxLIST_FORMAT_RIGHT,  180},
     {"Port Queue Length", ?wxLIST_FORMAT_RIGHT,  180}].

get_info(_) ->
    {ok,Info,TW} = crashdump_viewer:schedulers(),
    {Info,TW}.

get_details(_Id, not_found) ->
    Info = "The scheduler you are searching for could not be found.",
    {info,Info};
get_details(Id, Data) ->
    Proplist = crashdump_viewer:to_proplist(record_info(fields,sched),Data),
    {ok,{"Scheduler: " ++ Id,Proplist,""}}.

get_detail_cols(all) ->
    {[{sched, ?COL_ID}, {process, ?COL_PROC}, {process, ?COL_PORT}],true};
get_detail_cols(_) ->
    {[],false}.

%%%%%%%%%%%%%%%%%%%%%%%%

detail_pages() ->
    [{"Scheduler Information", fun init_gen_page/2}].

init_gen_page(Parent, Info0) ->
    Fields = info_fields(),
    Details = proplists:get_value(details, Info0),
    Info = if is_map(Details) -> Info0 ++ maps:to_list(Details);
	      true -> Info0
	   end,
    cdv_info_wx:start_link(Parent,{Fields,Info,[]}).

%%% Internal
info_fields() ->
    [{"Scheduler Overview",
      [{"Id",             id},
       {"Current Process",process},
       {"Current Port",   port},
       {"Sleep Info Flags", sleep_info},
       {"Sleep Aux Work",   sleep_aux}
      ]},
     {"Run Queues",
      [{"Flags",                   runq_flags},
       {"Priority Max Length",     runq_max},
       {"Priority High Length",    runq_high},
       {"Priority Normal Length",  runq_norm},
       {"Priority Low Length",     runq_low},
       {"Port Length",     port_q}
      ]},
     {"Current Process",
      [{"State",           currp_state},
       {"Internal State",  currp_int_state},
       {"Program Counter", currp_prg_cnt},
       {"CP",              currp_cp},
       {"Stack",           {currp_stack, 0}},
       {"     ",           {currp_stack, 1}},
       {"     ",           {currp_stack, 2}},
       {"     ",           {currp_stack, 3}},
       {"     ",           {currp_stack, 4}},
       {"     ",           {currp_stack, 5}},
       {"     ",           {currp_stack, 6}},
       {"     ",           {currp_stack, 7}},
       {"     ",           {currp_stack, 8}},
       {"     ",           {currp_stack, 9}},
       {"     ",           {currp_stack, 10}},
       {"     ",           {currp_stack, 11}}
      ]}
    ].
