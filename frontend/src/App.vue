<template>
  <router-view />
</template>

<style>
html,
body,
#app {
  margin: 0;
  padding: 0;
  overflow-x: hidden;
  width: 100%;
}

#app {
  font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #34495e;
}

nav {
  padding: 25px;
}

nav a {
  font-weight: 600;
  color: #34495e;
}

nav a.router-link-exact-active {
  color: #27ae60;
}
</style>
