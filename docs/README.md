# Set Game

![](homepage)

This is a single-player version of the Set game implemented in Swift using the MVVM architecture.

## Game Rules

Set is a card game with the following rules:

1. **Objective**: Find sets of three cards from the cards displayed on the table.
2. **Card Attributes**: Each card has four attributes, and each attribute has three possible values:
   - **Color**: Yellow, Blue, or Purple
   - **Shape**: Circle, Rectangle, or Rounded Rectangle
   - **Shading**: Reduced opacity, Filled, or Open
   - **Number**: One, Two, or Three

3. **What is a Set?** A set consists of three cards where each attribute, when considered individually, is either all the same or all different across the cards.
4. **Gameplay**:
   - 12 cards are initially dealt onto the table.
   - The player must identify and select a set from the displayed cards.
   - If a set is found, the cards forming the set are removed, and new cards are dealt to maintain 12 cards on the table.
   - The game continues until all cards have been dealt and no more sets are available.

## Architecture

This app is built using the MVVM (Model-View-ViewModel) architecture to separate concerns and enhance testability:

- **Model**: Represents the game's logic and data, including the deck of cards and set validation logic.
- **View**: Handles the UI and user interactions.
- **ViewModel**: Acts as an intermediary between the Model and the View, handling user input, game logic, and updating the UI.

## Acknowledgments

- [Set Enterprises](https://www.setgame.com) for the original game concept.
- The Swift community for their resources and support.
