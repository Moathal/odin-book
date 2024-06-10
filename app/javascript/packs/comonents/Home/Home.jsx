import React from 'react';
import Header from './Header/Header';
import Post from './Post/Post';

function Home(props) {
  const newsFeed = props.news_feeds;
  return (
    <>
      <Header />
      <div>
        {newsFeed.map((feed) => (
          <Post key={feed.id} props={feed} />
        ))}
      </div>
    </>
  );
}

export default Home;