import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Header from './components/Header/Header';
import Home from './components/Home/Home';
import Users from './components/Users/Users';


function App() {
  return (
		<Router>
			<Routes>
				<Route path='/' element={<Home />} />
				<Route path='/users' element={<Users />} />
				<Route path='/users/:userId' element={<User />} />
				<Route path='/users/:userId/posts' element={<Posts />} />
				<Route path='/users/:userId/posts/:postId' element={<Post />} />
				<Route path='/newsfeed' element={<Navigate to='/' />} />
			</Routes>
		</Router>
	);
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.createRoot(document.getElementById('root')).render(<App />);
});