const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from the 'app' directory
app.use(express.static(path.join(__dirname, '../public')));

/* Example API route
app.get('/api/data', (req, res) => {
  res.json({ message: 'Hello from API!' });
});*/

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
