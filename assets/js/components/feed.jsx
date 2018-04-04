import React from 'react'
import Post from './post'

export default function Feed(params) {
  let posts = _.map(params.posts, (pp) => <Post key={pp.id} post={pp} />)
  return (
    <div>
      { posts }
    </div>
  )
}
