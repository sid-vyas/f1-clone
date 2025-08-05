const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 5000;
const BASE_URL = 'https://api.jolpi.ca/ergast/f1';

// Helper to safely get standings lists
function getFirstList(data) {
  return data.MRData.StandingsTable.StandingsLists.length
    ? data.MRData.StandingsTable.StandingsLists[0]
    : null;
}

// Route: Get schedule (current or specific season)
app.get('/api/schedule/:season', async (req, res) => {
  try {
    const season = req.params.season || 'current';
    const response = await axios.get(`${BASE_URL}/${season}.json`);
    const races = response.data.MRData.RaceTable.Races;
    res.json(races);
  } catch (err) {
    console.error(`Error fetching schedule for season ${req.params.season}`, err.message);
    res.status(500).json({ message: 'Failed to fetch schedule' });
  }
});

// Route: Get driver standings (current or specific season)
app.get('/api/drivers/:season', async (req, res) => {
  try {
    const season = req.params.season || 'current';
    const response = await axios.get(`${BASE_URL}/${season}/driverStandings.json`);
    const standingsList = getFirstList(response.data);
    const drivers = standingsList ? standingsList.DriverStandings : [];
    res.json(drivers);
  } catch (err) {
    console.error(`Error fetching driver standings for season ${req.params.season}`, err.message);
    res.status(500).json({ message: 'Failed to fetch driver standings' });
  }
});

// Route: Get constructor (team) standings (current or specific season)
app.get('/api/teams/:season', async (req, res) => {
  try {
    const season = req.params.season || 'current';
    const response = await axios.get(`${BASE_URL}/${season}/constructorStandings.json`);
    const standingsList = getFirstList(response.data);
    const teams = standingsList ? standingsList.ConstructorStandings : [];
    res.json(teams);
  } catch (err) {
    console.error(`Error fetching team standings for season ${req.params.season}`, err.message);
    res.status(500).json({ message: 'Failed to fetch team standings' });
  }
});

// Route: Get race results for a specific season and round
app.get('/api/results/:season/:round', async (req, res) => {
  try {
    const { season, round } = req.params;
    const response = await axios.get(`${BASE_URL}/${season}/${round}/results.json`);
    const races = response.data.MRData.RaceTable.Races;
    const results = races.length ? races[0].Results : [];
    res.json(results);
  } catch (err) {
    console.error(`Error fetching results for season ${req.params.season}, round ${req.params.round}`, err.message);
    res.status(500).json({ message: 'Failed to fetch race results' });
  }
});

app.listen(PORT, () => {
  console.log(`Backend API server running on port ${PORT}`);
});
