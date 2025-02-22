#!/bin/bash

# Set up the backend
echo "Setting up the backend..."
cd backend
echo "OPENAI_API_KEY=sk-your-key" > .env
echo "ANTHROPIC_API_KEY=your-key" >> .env
poetry install
poetry run uvicorn main:app --reload --port 7001 &
BACKEND_PID=$!
cd ..

# Set up the frontend
echo "Setting up the frontend..."
cd frontend
yarn install
yarn dev &
FRONTEND_PID=$!
cd ..

# Wait for user to terminate
echo "Backend and frontend are running. Press [CTRL+C] to stop."
trap "kill $BACKEND_PID $FRONTEND_PID" EXIT
wait
