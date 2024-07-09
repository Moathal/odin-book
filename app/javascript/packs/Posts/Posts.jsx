import React from 'react'
import Post from './Post'

function Posts(props) {
  // console.log(`POSTS-PROPS:-------------> ${props}`);
  // console.log(`POSTS-PROPS-POSTS:-------------> ${props.posts.map((post) => {return post.text})}`);
  return (
		props.posts.map((post) => {
		return <Post key={post.id} props={post} />
		})
	);
}

export default Posts