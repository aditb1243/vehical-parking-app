<template>
  <NavBar />
  <div class="home-modern">
    <!-- Hero Section with Indian Theme -->
    <section class="hero-gradient">
      <div class="hero-overlay">
        <div class="container-modern hero-content">
          <div class="hero-text fade-in-up">
            <h1 class="hero-title">
              <span class="">Find Your Perfect</span><br />
              Parking Space
            </h1>
            <p class="hero-subtitle">
              <i class="bi bi-geo-alt-fill"></i>
              Book parking spots across Mumbai, Delhi, Bangalore, and more
            </p>
            <div class="hero-stats">
              <div class="stat-item">
                <span class="stat-number">{{ locations.length }}+</span>
                <span class="stat-label">Locations</span>
              </div>
              <div class="stat-divider"></div>
              <div class="stat-item">
                <span class="stat-number">500+</span>
                <span class="stat-label">Parking Spots</span>
              </div>
              <div class="stat-divider"></div>
              <div class="stat-item">
                <span class="stat-number">₹15-80</span>
                <span class="stat-label">Per Hour</span>
              </div>
            </div>
            <div class="hero-buttons">
              <router-link to="/login" class="btn-modern btn-primary btn-lg">
                <i class="bi bi-box-arrow-in-right"></i>
                Get Started
              </router-link>
              <router-link to="/register" class="btn-modern btn-outline btn-lg">
                <i class="bi bi-person-plus"></i>
                Sign Up Free
              </router-link>
            </div>
          </div>
          <div class="hero-visual fade-in">
            <div class="parking-illustration">
              <i class="bi bi-p-square-fill"></i>
            </div>
          </div>
        </div>
      </div>
      <div class="hero-wave">
        <svg viewBox="0 0 1200 120" preserveAspectRatio="none">
          <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"></path>
        </svg>
      </div>
    </section>

    <!-- Featured Locations -->
    <section class="locations-modern py-5">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            <span class="text-gradient">Popular</span> Parking Locations
          </h2>
          <p class="section-subtitle">Discover parking across India's major cities</p>
        </div>

        <div v-if="isLoadingLocations" class="text-center py-5">
          <div class="spinner-modern"></div>
          <p class="text-muted mt-3">Loading locations...</p>
        </div>

        <div v-else-if="locations.length" class="grid-modern">
          <div 
            v-for="(location, index) in locations" 
            :key="location.id"
            class="location-card-modern card-modern fade-in-up"
            :style="{ animationDelay: `${index * 0.1}s` }"
          >
            <div class="location-icon">
              <i class="bi bi-geo-alt-fill"></i>
            </div>
            <div class="location-info">
              <h3 class="location-name">{{ location.name }}</h3>
              <p class="location-city">
                <i class="bi bi-pin-map"></i>
                {{ location.city }}
              </p>
            </div>
            <div class="location-action">
              <router-link to="/login" class="btn-modern btn-primary btn-sm">
                Explore <i class="bi bi-arrow-right"></i>
              </router-link>
            </div>
          </div>
        </div>

        <div v-else class="text-center py-5 text-muted">
          <i class="bi bi-inbox" style="font-size: 3rem;"></i>
          <p class="mt-3">No locations available at the moment.</p>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features-modern py-5 bg-light">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            Why Choose <span class="text-gradient">ParkEase</span>?
          </h2>
          <p class="section-subtitle">Smart parking solutions for modern India</p>
        </div>

        <div class="row g-4">
          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-primary">
                <i class="bi bi-lightning-charge-fill"></i>
              </div>
              <h4 class="feature-title">Instant Booking</h4>
              <p class="feature-text">Book your spot in seconds with our fast and intuitive platform</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-accent">
                <i class="bi bi-shield-check"></i>
              </div>
              <h4 class="feature-title">Secure Payment</h4>
              <p class="feature-text">Safe and secure transactions with multiple payment options</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-secondary">
                <i class="bi bi-calendar-check"></i>
              </div>
              <h4 class="feature-title">24/7 Availability</h4>
              <p class="feature-text">Find and book parking anytime, anywhere in India</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #00B894 0%, #55EFC4 100%)">
                <i class="bi bi-wallet2"></i>
              </div>
              <h4 class="feature-title">Best Prices</h4>
              <p class="feature-text">Transparent pricing starting from just ₹15/hour</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- How It Works -->
    <section class="how-it-works py-5">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            How It <span class="text-gradient">Works</span>
          </h2>
          <p class="section-subtitle">Park your vehicle in 3 simple steps</p>
        </div>

        <div class="steps-container">
          <div class="step-item">
            <div class="step-number gradient-primary">1</div>
            <div class="step-content">
              <h4>Search Location</h4>
              <p>Find parking spots near your destination</p>
            </div>
          </div>

          <div class="step-connector"></div>

          <div class="step-item">
            <div class="step-number gradient-accent">2</div>
            <div class="step-content">
              <h4>Book Your Spot</h4>
              <p>Reserve your parking spot in advance</p>
            </div>
          </div>

          <div class="step-connector"></div>

          <div class="step-item">
            <div class="step-number gradient-secondary">3</div>
            <div class="step-content">
              <h4>Park & Relax</h4>
              <p>Arrive and park stress-free</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section gradient-hero text-white py-5">
      <div class="container-modern text-center">
        <h2 class="display-5 fw-bold mb-3">Ready to Find Your Parking Spot?</h2>
        <p class="lead mb-4">Join thousands of happy users across India</p>
        <router-link to="/register" class="btn-modern btn-accent btn-lg">
          <i class="bi bi-rocket-takeoff"></i>
          Start Parking Smart
        </router-link>
      </div>
    </section>
  </div>
</template>

<script>
import NavBar from '@/components/NavBar.vue';
import userMixin from '@/mixins/userMixin';
import { toast } from 'vue3-toastify';

export default {
  name: 'HomeView',
  mixins: [userMixin],
  components: {
    NavBar
  },
  data() {
    return {
      locations: [],
      isLoadingLocations: false
    };
  },
  async mounted() {
    await this.fetchLocations();
  },
  methods: {
    async fetchLocations() {
      this.isLoadingLocations = true;
      try {
        const response = await fetch('http://127.0.0.1:5000/get_locations', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json'
          }
        });

        if (response.ok) {
          const data = await response.json();
          this.locations = data.locations;
        } else {
          const errorData = await response.json();
          toast.error(errorData.message || 'Failed to fetch locations.', { position: 'top-center' });
        }
      } catch (error) {
        console.error('Error fetching locations:', error);
        toast.error('Server error while fetching locations.', { position: 'top-center' });
      } finally {
        this.isLoadingLocations = false;
      }
    }
  }
}
</script>

<style scoped>
/* Hero Section */
.hero-gradient {
  position: relative;
  min-height: 90vh;
  background: linear-gradient(135deg, #004E89 0%, #1A6FB0 25%, #FF6B35 75%, #FFB627 100%);
  overflow: hidden;
}

.hero-overlay {
  background: rgba(0, 0, 0, 0.3);
  min-height: 90vh;
  display: flex;
  align-items: center;
  padding: 2rem 0;
}

.hero-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 1.5rem;
  color: white;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.95);
  margin-bottom: 2rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.hero-stats {
  display: flex;
  gap: 2rem;
  margin-bottom: 2.5rem;
  flex-wrap: wrap;
}

.stat-item {
  display: flex;
  flex-direction: column;
}

.stat-number {
  font-size: 2rem;
  font-weight: 700;
  color: var(--accent-color);
}

.stat-label {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.8);
}

.stat-divider {
  width: 2px;
  background: rgba(255, 255, 255, 0.3);
}

.hero-buttons {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.btn-lg {
  padding: 1rem 2rem;
  font-size: 1.1rem;
}

.hero-visual {
  display: flex;
  justify-content: center;
  align-items: center;
}

.parking-illustration {
  width: 300px;
  height: 300px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 3px solid rgba(255, 255, 255, 0.3);
  animation: float 3s ease-in-out infinite;
}

.parking-illustration i {
  font-size: 10rem;
  color: var(--accent-color);
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-20px);
  }
}

.hero-wave {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  overflow: hidden;
  line-height: 0;
}

.hero-wave svg {
  position: relative;
  display: block;
  width: calc(100% + 1.3px);
  height: 80px;
}

.hero-wave path {
  fill: var(--background-primary);
}

/* Location Cards */
.location-card-modern {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.location-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
  border-radius: var(--radius-md);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.8rem;
}

.location-name {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0;
}

.location-city {
  color: var(--text-secondary);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* Feature Cards */
.feature-card-modern {
  padding: 2rem 1.5rem;
  height: 100%;
}

.feature-icon-wrapper {
  width: 80px;
  height: 80px;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.5rem;
  color: white;
  font-size: 2.5rem;
}

.feature-title {
  font-size: 1.25rem;
  font-weight: 700;
  margin-bottom: 0.75rem;
  color: var(--text-primary);
}

.feature-text {
  color: var(--text-secondary);
  margin: 0;
}

/* How It Works */
.steps-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2rem;
  flex-wrap: wrap;
  max-width: 1000px;
  margin: 0 auto;
}

.step-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  flex: 1;
  min-width: 200px;
}

.step-number {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.step-content h4 {
  font-weight: 700;
  margin-bottom: 0.5rem;
  color: var(--text-primary);
}

.step-content p {
  color: var(--text-secondary);
  margin: 0;
}

.step-connector {
  width: 100px;
  height: 4px;
  background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
  border-radius: var(--radius-full);
}

/* Section Headers */
.section-title {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 0.75rem;
}

.section-subtitle {
  font-size: 1.1rem;
  color: var(--text-secondary);
}

/* Responsive */
@media (max-width: 968px) {
  .hero-content {
    grid-template-columns: 1fr;
    text-align: center;
  }

  .hero-title {
    font-size: 2.5rem;
  }

  .hero-stats {
    justify-content: center;
  }

  .hero-buttons {
    justify-content: center;
  }

  .step-connector {
    display: none;
  }
}
</style>
