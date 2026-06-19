<h1>FocusBuddy 🌙🎯</h1>

<p>
  <a href="https://github.com/PritamSapkal/FocusBuddy/releases">
    <img src="https://img.shields.io/badge/APK-Download-green?style=for-the-badge&logo=android" alt="APK Download">
  </a>
  <a href="https://github.com/PritamSapkal/FocusBuddy/stargazers">
    <img src="https://img.shields.io/github/stars/PritamSapkal/FocusBuddy?style=for-the-badge&color=gold" alt="GitHub Stars">
  </a>
</p>

<p><b>Tagline:</b> <i>Sharpen Your Vision. Persist Your Progress. Own Your Day.</i></p>

<p>
FocusBuddy is a premium, high-fidelity productivity and focus tracking mobile application engineered using Flutter. Architected with an emphasis on state synchronization and reliable session management, FocusBuddy empowers users to define their critical daily objectives and intuitively track task execution metrics through a modern, responsive user experience.
</p>

<hr>

<h2>📌 About the Application</h2>

<p>
FocusBuddy represents a rapid, high-intensity engineering milestone—fully designed, architected, and brought to production readiness within a focused 2-day sprint. The primary architectural objective of this project was to master clean state management separation using the Observer pattern alongside robust client-side session persistence. It moves past static mockups to implement active state binding, persistent data hydration, and fluid geometric progress rendering.
</p>

<hr>

<h2>🖼️ Application Showcase</h2>

<p align="center">
  <img src="focusbuddy/Screenshots/splashscreen_page.png" width="31%" alt="Splash Screen Layout" />
  <img src="focusbuddy/Screenshots/loginscreen_page.png" width="31%" alt="Authentication Interface" />
  <img src="focusbuddy/Screenshots/homescreen_page.png" width="31%" alt="Focus Dashboard and Progress Engine" />
</p>

<hr>

<h2>✨ Core Engineering Features</h2>

<ul>
  <li>⚡ <b>Reactive State Management:</b> Powered entirely by <b>Provider</b> to establish a strict unidirectional data flow, ensuring all progress modifications instantly propagate across the UI layer without unnecessary widget rebuilds.</li>
  <li>🔒 <b>Persistent Authentication Lifecycle:</b> Implements intelligent session caching via <b>Shared Preferences</b>. Active login tokens are verified during initialization, allowing authenticated users to bypass the login layout entirely and auto-route straight to the dashboard.</li>
  <li>📊 <b>High-Fidelity Progress Visualization:</b> Integrates an interactive circular percent indicator that dynamically translates task completion steps into real-time visual progress arcs, featuring centered integer text reflections.</li>
  <li>💾 <b>State Hydration & Crash Resilience:</b> Automatically synchronizes the user's focus goals, task data, and exact progress metrics to local device storage. If the application process is terminated, the full state is restored seamlessly upon relaunch.</li>
  <li>🚪 <b>Secure Session Invalidation:</b> Features a unified logout routine that completely flushes stored authentication flags and state metrics before safely re-routing the user back to the primary gateway interface.</li>
</ul>

<hr>

<h2>🧭 Application Architecture Workflow</h2>

<ol>
  <li>
    <b>Pre-Boot Environment Setup</b>
    <ul>
      <li>During the Splash Screen phase, the application queries local Shared Preferences storage to check for existing authentication flags and cached task configurations.</li>
    </ul>
  </li>

  <li>
    <b>Dynamic Gateway Routing</b>
    <ul>
      <li>If a persistent session flag exists, the router immediately mounts the Home Screen dashboard. If no session is found, the user is cleanly directed to the Login Screen interface.</li>
    </ul>
  </li>

  <li>
    <b>State Interaction & Increment Optimization</b>
    <ul>
      <li>The Home Dashboard exposes interactive control nodes (Add/Remove steps). Interaction triggers state dispatches inside the change notifier, computing new percentages and writing updates to disk asynchronously.</li>
    </ul>
  </li>

  <li>
    <b>Session De-authorization</b>
    <ul>
      <li>Triggering the Logout command clears state models, executes a structural wipe of local persistence blocks, and rebuilds the navigation stack to prevent unauthorized deep linking back to the dashboard.</li>
    </ul>
  </li>
</ol>

<hr>

<h2>🛠️ Tech Stack & Dependencies</h2>

<ul>
  <li><b>Framework:</b> Flutter (Stable Channel)</li>
  <li><b>Language:</b> Dart</li>
  <li><b>State Core:</b> <code>provider</code></li>
  <li><b>Local Caching Layer:</b> <code>shared_preferences</code></li>
  <li><b>UI Motion & Graphics:</b> <code>circular_percent_indicator</code></li>
  <li><b>Target Platform:</b> Android (API 21+) / iOS</li>
</ul>

<hr>

<h2>🚧 Current Development Status</h2>

<p>✅ <b>v1.0.0 Completed</b> (The 2-day architectural sprint succeeded with full state synchronization, session persistence, and custom neon dark-mode UI layouts fully production-ready).</p>

<hr>

<h2>🔮 Future Architecture Enhancements</h2>

<ul>
  <li>📈 Historical focus analytics sheets to display weekly and monthly productivity trends.</li>
  <li>⏱️ Integrated Pomodoro Focus Engine with background countdown workers and local alarms.</li>
  <li>🌌 Expanded state implementation covering more granular multi-task checklists per day.</li>
</ul>

<hr>

<h2>🚀 Local Setup & Installation</h2>

<p>To clone and audit the FocusBuddy codebase locally on your machine, execute the following setup sequence inside your terminal:</p>

<pre>
git clone https://github.com/PritamSapkal/FocusBuddy.git
cd FocusBuddy
flutter pub get
flutter run
</pre>

<hr>

<h2>🤝 Contribution & Code Review</h2>

<p>
This repository showcases solid foundational patterns for reactive UI programming and session persistence using Flutter. Recommendations regarding alternative state frameworks (e.g., Riverpod transitions) or encrypted local storage structures are highly welcomed.
</p>

<hr>

<h2>📄 Educational License</h2>

<p>This application is engineered strictly for learning, architectural demonstration, and educational portfolio purposes.</p>

<hr>

<p align="center">⭐ If you find this engineering implementation useful, feel free to star the repository!</p>