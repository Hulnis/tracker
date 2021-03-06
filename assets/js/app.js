// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function new_time_block() {
  let text = JSON.stringify({
    time_block: {
        start_time: new Date().toISOString(),
        stop_time: new Date().toISOString(),
        task_id: task_id
      },
  })

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { location.reload() },
  })
}


function update_time_block(ev) {
  let btn = $(ev.target);
  let timeblock_id = btn.data('timeblock-id');
  let new_start_time = document.getElementById("start-time-form-" + timeblock_id).value
  let new_stop_time = document.getElementById("stop-time-form-" + timeblock_id).value

  let text = JSON.stringify({
    time_block: {
        start_time: new_start_time,
        stop_time: new_stop_time,
        task_id: task_id
      },
  })

  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "patch",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { location.reload() },
  })
}

function delete_time_block(ev) {
  let btn = $(ev.target);
  let timeblock_id = btn.data('timeblock-id');

  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => { location.reload() },
  })
}


function click_handler() {
  $(".new-task-button").click(new_time_block);
  $(".update-task-button").click(update_time_block);
  $(".delete-task-button").click(delete_time_block);
}

$(click_handler);
