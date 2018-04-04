
import React from 'react'
import { connect } from 'react-redux'
import { Button, FormGroup, Label, Input } from 'reactstrap'
import NumericInput from 'react-numeric-input';
import api from '../api'

function TaskForm(props) {
  console.log("props@TaskForm", props)

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
      <h2>New Task</h2>
      <FormGroup>
        <Label for="title">Title</Label>
        <Input type="input" name="title" value={props.form.title} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="body">Body</Label>
        <Input type="textarea" name="body" value={props.form.body} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="is_complete">Task Complete?</Label>
        <Input type="checkbox" name="is_complete" value={props.form.is_complete} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="assigned_user">Assign To (optional)</Label>
        <Input type="text" name="assigned_user" value={props.form.assigned_user} onChange={update} />
      </FormGroup>
      <FormGroup>
        <NumericInput step={15} value={props.form.time_spent} onChange={update}/>
      </FormGroup>
      <Button onClick={submit} color="primary">Post</Button> &nbsp
      <Button onClick={clear}>Clear</Button>
    </div>
  )
}

function state2props(state) {
  console.log("rerender@TaskForm", state)
  return {
    form: state.form,
  }
}

export default connect(state2props)(TaskForm)
