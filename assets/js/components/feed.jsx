import React from 'react'
import Post from './post'

export default function Feed(params) {
  let tasks = _.map(params.tasks, (pp) => <Task key={pp.id} post={pp} />)
  return (
    <div>
      { tasks }
    </div>
  )
}
