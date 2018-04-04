import { createStore, combineReducers } from 'redux'
import deepFreeze from 'deep-freeze'

function tasks(state = [], action) {
  switch (action.type) {
  case 'TASKS_LIST':
    return [...action.tasks]
  case 'ADD_TASK':
    return [action.task, ...state]
  default:
    return state
  }
}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return [...action.users]
  case 'ADD_USER':
    return [action.user, ...state]
  default:
    return state
  }
}

let empty_task_form = {
  title: "",
  body: "",
  is_complete: false,
  assigned_user: "",
  time_spent: 0,
}

function task_form(state = empty_task_form, action) {
  switch (action.type) {
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data)
    case 'CLEAR_FORM':
      return Object.assign({}, state, empty_task_form)
    case 'SET_TOKEN':
      return Object.assign({}, state, action.token)
    default:
      return state
  }
}

let empty_task_update_form = {

}

function edit_task_form(state = empty_task_update_form, action) {
  switch (action.type) {
    case 'UPDATE_EDIT_FORM':
      if(state[action.data.id]) {
        return Object.assign({}, state[action.data.id], action.data.update)
      } else {
        console.log("state1", state)
        state = Object.assign({}, state, {action.data.id: {}})
        console.log("state2", state)
        return Object.assign({}, state[action.data.id], action.data.update)
      }
    case 'SET_TOKEN':
      return Object.assign({}, state, action.token)
    default:
      return state
  }
}

let empty_user_form = {
  name: "",
  email: "",
  password: "",
}

function user_form(state = empty_user_form, action) {
  switch (action.type) {
    case 'USER_UPDATE_FORM':
      return Object.assign({}, state, action.data)
    case 'USER_CLEAR_FORM':
      return Object.assign({}, state, empty_user_form)
    case 'SET_TOKEN':
      return Object.assign({}, state, action.token)
    default:
      return state
  }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token
    default:
      return state
  }
}

let empty_login = {
  name: "",
  pass: "",
}

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data)
    default:
      return state
  }
}

function root_reducer(state0, action) {
  console.log("reducer", action)
  // {posts, users, form} is ES6 shorthand for
  // {posts: posts, users: users, form: form}
  let reducer = combineReducers({tasks, users, task_form, user_form, token, login, edit_task_form})
  let state1 = reducer(state0, action)
  console.log("state1", state1)
  return deepFreeze(state1)
}

let store = createStore(root_reducer)
export default store
