### Steps to Run the App
1. Run the app

### Focus Areas
Architecture, scalability, and user experience were the focus areas.

- Dependency injection enables mocking in unit tests and provides easy debug data for Swift Previews
- Displayables offer abstraction from data models so it’s easy to switch between data providers in the future
- The Coordinator pattern keeps navigation centralised and theoretically enables easy deep linking

### Time Spent
About six hours were spent on this project spread out over a few days as time permitted.

### Trade-Offs and Decisions
- If I had more time I would have built a better dependency injection system
- More unit tests could probably be written

### Weakest Part of the Project
- CachedImage could be a little bit more configurable.

### Additional Information
- I started with NavigationStack and ended up falling back to a UIHostingController pattern for presentation and navigation. I’d love to experiment more and learn from colleagues to see if a better approach could be used!
- Again, if I had more time I’d planned to implement sorting by cuisine. But I think it’s better to have a solid foundation than to have every “nice-to-have” feature implemented in version 1.0.