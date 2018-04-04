import React from 'react'
import ReactDOM from 'react-dom'
import { Provider, connect } from 'react-redux'
import { BrowserRouter as Router, Route } from 'react-router-dom'

import Nav from './nav'
import Feed from './feed'
import Users from './users'
import TaskForm from './tasks-form'

export default function tracker_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <Tracker state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  )
}

let Tracker = connect((state) => state)((props) => {
  return (
    <Router>
      <div>
        <Nav />
        <Route path="/" exact={true} render={() =>
          <div>
            <TaskForm />
            <Feed tasks={props.tasks} />
          </div>
        } />
        <Route path="/users" exact={true} render={() =>
          <Users users={props.users} />
        } />
        <Route path="/users/:user_id" render={({match}) =>
            <Feed tasks={_.filter(props.tasks, (t) =>
              match.params.user_id == t.user.id )
            } />
          } />
      </div>
    </Router>
  )
})
