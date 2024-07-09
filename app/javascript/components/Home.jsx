import React from 'react';
import Header from './Header/Header';
import Post from './Post/Post';

function Home(props) {
  const newsFeed = props.news_feeds;
  return (
      <div>
        return <Posts props={newsFeed} />
      </div>
  );
}

export default Home;