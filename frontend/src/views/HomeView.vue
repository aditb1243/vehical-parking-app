<template>
  <NavBar />
  <div class="home-modern">
    <!-- Hero Section -->
    <section class="hero-gradient">
      <div class="hero-overlay">
        <div class="container">
          <div class="row align-items-center justify-content-center text-center">
            <div class="col-lg-10">
              <div class="hero-content animate-fade-in">
                <h1 class="hero-title mb-4">
                  Find Your Perfect Parking Space
                </h1>
                <p class="hero-subtitle mb-5">
                  <i class="bi bi-geo-alt-fill me-2"></i>
                  Book parking spots in advance across major cities
                </p>
                
                <div class="hero-stats d-flex gap-4 mb-5 justify-content-center flex-wrap">
                  <div class="stat-item">
                    <h3 class="stat-number">{{ locations.length }}+</h3>
                    <p class="stat-label">Cities</p>
                  </div>
                  <div class="stat-item">
                    <h3 class="stat-number">500+</h3>
                    <p class="stat-label">Parking Spots</p>
                  </div>
                  <div class="stat-item">
                    <h3 class="stat-number">₹15-80</h3>
                    <p class="stat-label">Per Hour</p>
                  </div>
                </div>

                <div class="hero-actions d-flex gap-3 justify-content-center flex-wrap">
                  <router-link to="/search" class="btn btn-hero-primary btn-lg">
                    <i class="bi bi-search me-2"></i>Find Parking
                  </router-link>
                  <router-link to="/register" class="btn btn-hero-secondary btn-lg">
                    <i class="bi bi-person-plus me-2"></i>Sign Up Free
                  </router-link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Featured Locations -->
    <section class="locations-modern py-5">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            <span class="text-gradient">Featured</span> Parking Areas
          </h2>
          <p class="section-subtitle">Explore parking in key metropolitan zones</p>
        </div>

        <div v-if="isLoadingLocations" class="text-center py-5">
          <div class="spinner-modern"></div>
          <p class="text-muted mt-3">Retrieving areas...</p>
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
                View Details <i class="bi bi-arrow-right"></i>
              </router-link>
            </div>
          </div>
        </div>

        <div v-else class="text-center py-5 text-muted">
          <i class="bi bi-inbox" style="font-size: 3rem;"></i>
          <p class="mt-3">No areas currently available</p>
        </div>
      </div>
    </section>

    <section class="features-modern py-5 bg-light">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            Why Choose <span class="text-gradient">ParkEase</span>?
          </h2>
          <p class="section-subtitle">Intelligent parking for urban drivers</p>
        </div>

        <div class="row g-4">
          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-primary">
                <i class="bi bi-lightning-charge-fill"></i>
              </div>
              <h4 class="feature-title">Quick Reservation</h4>
              <p class="feature-text">Secure your spot instantly using our streamlined interface</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-accent">
                <i class="bi bi-shield-check"></i>
              </div>
              <h4 class="feature-title">Safe Transactions</h4>
              <p class="feature-text">Protected payments with diverse transaction methods</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper gradient-secondary">
                <i class="bi bi-calendar-check"></i>
              </div>
              <h4 class="feature-title">24/7 Access</h4>
              <p class="feature-text">Locate and reserve parking whenever needed</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-card-modern card-modern text-center">
              <div class="feature-icon-wrapper" style="background: linear-gradient(120deg, #27ae60 0%, #58d68d 100%)">
                <i class="bi bi-wallet2"></i>
              </div>
              <h4 class="feature-title">Competitive Rates</h4>
              <p class="feature-text">Clear pricing beginning at only ₹15 per hour</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="how-it-works py-5">
      <div class="container-modern">
        <div class="section-header text-center mb-5">
          <h2 class="section-title">
            Our <span class="text-gradient">Process</span>
          </h2>
          <p class="section-subtitle">Secure your spot in three simple steps</p>
        </div>

        <div class="steps-container">
          <div class="step-item">
            <div class="step-number gradient-primary">1</div>
            <div class="step-content">
              <h4>Find Area</h4>
              <p>Locate spaces near your destination</p>
            </div>
          </div>

          <div class="step-connector"></div>

          <div class="step-item">
            <div class="step-number gradient-accent">2</div>
            <div class="step-content">
              <h4>Reserve Space</h4>
              <p>Confirm your selection ahead of time</p>
            </div>
          </div>

          <div class="step-connector"></div>

          <div class="step-item">
            <div class="step-number gradient-secondary">3</div>
            <div class="step-content">
              <h4>Arrive & Park</h4>
              <p>Reach and use your reserved spot</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="cta-section gradient-hero text-white py-5">
      <div class="container-modern text-center">
        <h2 class="display-5 fw-bold mb-3">Ready to Secure Your Space?</h2>
        <p class="lead mb-4">Join satisfied drivers nationwide</p>
        <router-link to="/register" class="btn-modern btn-accent btn-lg">
          <i class="bi bi-rocket-takeoff"></i>
          Park Smarter Today
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
.hero-gradient {
  position: relative;
  min-height: calc(100vh - 60px);
  background: linear-gradient(135deg, #2980b9 0%, #27ae60 50%, #e67e22 100%);
  overflow: hidden;
}

.hero-overlay {
  background: rgba(0, 0, 0, 0.15);
  min-height: calc(100vh - 60px);
  display: flex;
  align-items: center;
  padding: 4rem 0;
}

.hero-title {
  font-size: 4rem;
  font-weight: 800;
  color: white;
  line-height: 1.2;
  text-shadow: 0 3px 15px rgba(0, 0, 0, 0.3);
  margin-bottom: 1.5rem;
}

.hero-subtitle {
  font-size: 1.5rem;
  color: rgba(255, 255, 255, 0.98);
  font-weight: 400;
  text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.hero-stats {
  display: flex;
  gap: 3rem;
  padding: 2rem 0;
}

.stat-item {
  text-align: center;
  background: rgba(255, 255, 255, 0.1);
  padding: 1.5rem 2rem;
  border-radius: 12px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  min-width: 140px;
}

.stat-number {
  font-size: 3rem;
  font-weight: 800;
  color: white;
  margin: 0;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

.stat-label {
  color: rgba(255, 255, 255, 0.95);
  font-size: 1rem;
  margin: 0.5rem 0 0 0;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  font-weight: 500;
}

.btn-hero-primary {
  background: white;
  color: var(--primary-color);
  border: none;
  padding: 1rem 2.5rem;
  font-size: 1.2rem;
  font-weight: 700;
  border-radius: 50px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.btn-hero-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
  color: var(--primary-color);
  background: #f8f9fa;
}

.btn-hero-secondary {
  background: rgba(255, 255, 255, 0.15);
  color: white;
  border: 2px solid white;
  padding: 1rem 2.5rem;
  font-size: 1.2rem;
  font-weight: 700;
  border-radius: 50px;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
}

.btn-hero-secondary:hover {
  background: white;
  color: var(--primary-color);
  transform: translateY(-3px);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
}

.animate-fade-in {
  animation: fadeInUp 0.8s ease-out;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.location-card-modern {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.location-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(120deg, var(--primary-color), var(--primary-dark));
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

.location-info {
  flex: 1;
}

.feature-card-modern {
  padding: 2.5rem 2rem;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.feature-icon-wrapper {
  width: 85px;
  height: 85px;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.5rem;
  color: white;
  font-size: 2.8rem;
}

.feature-title {
  font-size: 1.3rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: var(--text-primary);
  text-align: center;
}

.feature-text {
  color: var(--text-secondary);
  margin: 0;
  text-align: center;
  line-height: 1.6;
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
