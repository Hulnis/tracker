import React from 'react'
import { connect } from 'react-redux'
import { Card, CardBody, CardTitle } from 'reactstrap'
import { Button, FormGroup, Label, Input, Checkbox } from 'reactstrap'
import NumericInput from 'react-numeric-input';
import api from '../api'

function Task(params) {
  let task = params.task

  function update(ev) {
    ev.preventDefault()
    console.log("update", ev)
    console.log("update", ev.target)
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

  function updateTime(timeAsInt) {
    let form_data = {}
    form_data["time_spent"] = timeAsInt

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
    api.submit_task_update(params.forms[task.id], task.id, params.forms.token)
    console.log(params.forms)
  }

  return (
    <Card>
      <CardTitle>Task: {task.title}</CardTitle>
        <FormGroup check inline>
          <Label for="is_complete">Task Complete?</Label>
          <Input type="checkbox" name="is_complete" value={params.forms[task.id].is_complete} onChange={update} />
        </FormGroup>
      <FormGroup>
        <Label for="assigned_user">Assigned To (optional)</Label>
        <Input type="text" name="assigned_user" onChange={update} value={params.forms[task.id].assigned_user} />
      </FormGroup>
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
