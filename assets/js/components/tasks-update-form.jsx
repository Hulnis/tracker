
import React from 'react'
import { connect } from 'react-redux'
import { Button, FormGroup, Label, Input } from 'reactstrap'
import NumericInput from 'react-numeric-input';
import api from '../api'

function TaskForm(props) {
  let action = {
    type: 'EDIT_UPDATE_FORM',
    data:
  }

  function update(ev) {
    let tgt = $(ev.target)

    let data = {}
    data[tgt.attr('name')] = tgt.val()
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    }
    console.log(action)
    props.dispatch(action)
  }

  function submit(ev) {
    api.submit_task(props.form)
    console.log(props.form)
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_FORM',
    })
  }

  return (
    <div style={{padding: "4ex"}}>
      <Card>
        <h2>Update Task</h2>
        <CardTitle>Task: {task.title}</CardTitle>
        <FormGroup>
          <Label for="body">Body</Label>
          <Input type="textarea" name="body" value={props.form.body} onChange={update} />
        </FormGroup>
        <FormGroup>
          <Input type="checkbox" name="is_complete" value={props.form.is_complete} onChange={update} />
          <Label for="is_complete">Task Complete?</Label>
        </FormGroup>
        <FormGroup>
          <Label for="assigned_user">Assign To (optional)</Label>
          <Input type="text" name="assigned_user" value={props.form.assigned_user} onChange={update} />
        </FormGroup>
        <FormGroup>
          <NumericInput step={15} value={props.form.time_spent} onChange={update}/>
        </FormGroup>
        <Button onClick={submit} color="primary">Post</Button>
        <Button onClick={clear}>Clear</Button>
      </Card>
    </div>
  )
}

function state2props(state) {
  console.log("rerender@TaskForm", state)
  return {
    form: state.edit_task_form,
  }
}

export default connect(state2props)(TaskForm)
