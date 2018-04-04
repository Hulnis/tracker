import React from 'react'
import { connect } from 'react-redux'
import { Card, CardBody, CardTitle } from 'reactstrap'
import { Button, FormGroup, Label, Input } from 'reactstrap'
import NumericInput from 'react-numeric-input';

function Task(params) {
  console.log("Task params", params)
  let task = params.task

  function update(ev) {
    let tgt = $(ev.target)

    let form_data = {}
    form_data[tgt.attr('name')] = tgt.val()

    let data = {}
    data["id"] = params.task.id
    data["update"] = form_data

    let action = {
      type: 'UPDATE_EDIT_FORM',
      data: data,
    }
    console.log(action)
    params.dispatch(action)
  }

  function updateTime(timeAsInt, timeAsString) {
    let form_data = {}
    form_data["time_spent"] = timeAsString

    let data = {}
    data["id"] = params.task.id
    data["update"] = form_data

    let action = {
      type: 'UPDATE_EDIT_FORM',
      data: data,
    }
    console.log(action)
    params.dispatch(action)
  }

  function submit(ev) {
    api.submit_task_update(params.forms[task.id], task.id)
    console.log(params.forms)
  }

  return (
    <Card>
      <CardTitle>Task: {task.title}</CardTitle>
      <FormGroup>
        <Label for="assigned_user">Assign To (optional)</Label>
        <Input type="text" name="assigned_user" onChange={update} value={params.forms[task.id].assigned_user} />
      </FormGroup>
      <CardTitle>Status: {task.is_complete ? "Complete" : "Not Complete"}</CardTitle>
      <FormGroup>
        <NumericInput step={15} value={params.forms[task.id].time_spent} onChange={updateTime} />
      </FormGroup>
      <CardBody>
        <div>
          <p>Body: { task.body }</p>
        </div>
      </CardBody>
      <Button onClick={submit} color="primary">Update</Button>
    </Card>
  )
}

function state2props(state) {
  console.log("rerender@Task", state)
  return {
    forms: state.edit_task_form,
  }
}

export default connect(state2props)(Task)
