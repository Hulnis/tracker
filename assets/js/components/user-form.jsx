
import React from 'react'
import { connect } from 'react-redux'
import { Button, FormGroup, Label, Input } from 'reactstrap'
import NumericInput from 'react-numeric-input';
import api from '../api'

function UserForm(props) {
  console.log("props@UserForm", props)

  function update(ev) {
    let tgt = $(ev.target)

    let data = {}
    data[tgt.attr('name')] = tgt.val()
    let action = {
      type: 'USER_UPDATE_FORM',
      data: data,
    }
    console.log(action)
    props.dispatch(action)
  }

  function submit(ev) {
    api.submit_user(props.form)
    console.log(props.form)
  }

  function clear(ev) {
    props.dispatch({
      type: 'USER_CLEAR_FORM',
    })
  }

  return (
    <div style={{padding: "4ex"}}>
      <h2>New User</h2>
      <FormGroup>
        <Label for="email">Email</Label>
        <Input type="input" name="email" value={props.form.email} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="name">Name</Label>
        <Input type="input" name="name" value={props.form.name} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="password">Password</Label>
        <Input type="password" name="password" value={props.form.password} onChange={update} />
      </FormGroup>
      <Button onClick={submit} color="primary">Post</Button>
      <Button onClick={clear}>Clear</Button>
    </div>
  )
}

function state2props(state) {
  console.log("rerender@UserForm", state)
  return {
    form: state.user_form,
  }
}

export default connect(state2props)(UserForm)
