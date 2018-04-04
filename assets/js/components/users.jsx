import React from 'react'
import { Link } from 'react-router-dom'
import UserForm from './user-form.jsx'

function User(params) {
  return <p>{params.user.name} - <Link to={"/users/" + params.user.id}>posts</Link></p>
}

export default function Users(params) {
  let users = params.users.map((uu) => <User key={uu.id} user={uu} />)
  return (
    <div>
      <UserForm />
      { users }
    </div>
  )
}
