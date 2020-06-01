<template>
  <div id="app">
    <NavBar />
    <div class="container">
      <div class="hero">
          <div class="image-container">
              <img src="@/assets/images/background.svg" alt="App Review">
          </div>
          <div class="header">
              <h1>Bucket Design<span class="blue-dot">.</span></h1>
              <p class="undertitle">L'app per tutti i Digital Designers.</p>
              <div class="buttons">
                <a href="/" class="button blue">
                  <span>
                    <img src="@/assets/images/play_store_logo.svg" alt="Play Store Logo">
                  </span>
                  <p>Play Store</p>
                </a>
                <a href="/" class="button">
                  <span>
                    <img src="@/assets/images/apple_store_logo.svg" alt="Apple Store Logo">
                  </span>
                  <p>Apple Store</p>
                </a>
              </div>
          </div>
      </div>

      <ul>

        <li class="card blue">
          <h1>Come funziona?</h1>
          <p>Puoi creare un account o registrarti se ne hai già uno. Messaggia, condividi e divertiti a creare con Digital Designers di tutto il mondo.</p>
        </li>

        <li class="card">
          <h1>A chi è rivolto?</h1>
          <p>L’app è rivolta a tutti quelli che hanno una passione per i lavori grafici. Non sei un designer? Non c’è problema! Puoi comunque usare l’app!</p>
        </li>

      </ul>

    </div>
  </div>
</template>


<script>

// Components
import NavBar from './components/NavBar';

export default {
  title: "Bucket Design.",
  name: 'Landing Page',
  components: {
    NavBar
  }
}
</script>


<style lang="scss">
  @import '@/assets/scss/main.scss';
</style>
