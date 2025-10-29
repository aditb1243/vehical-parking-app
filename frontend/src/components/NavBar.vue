<template>
    <nav class="navbar bg-dark text-light navbar-expand-lg" style="position: sticky; top: 0; z-index: 1030;">
        <div class="container-fluid">
           
            <router-link class="navbar-brand text-primary fw-bold" to="/">Park<font class="text-secondary">Ease</font>
            </router-link>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul v-if="loggedIn && user && !user.admin" class="navbar-nav me-auto px-2">
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/user_dashboard">Dashboard</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/book_parking">Reserve</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/user_search">Find</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/user_summary">Reports</router-link>
                    </li>
                </ul>
                <ul v-if="loggedIn && user && user.admin" class="navbar-nav ms-auto px-2">
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/admin_dashboard">Dashboard</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/user_management">Manage Users</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/search">Lookup</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="btn btn-outline-success" to="/admin_summary">Analytics</router-link>
                    </li>
                </ul>

                <ul v-if="loggedIn" class="navbar-nav ms-auto px-2">
                    <li v-if="!user.admin" class="nav-item px-2">
                        <router-link class="nav-link" to="/user_profile">
                            {{ user.username }}
                        </router-link>
                    </li>
                    <li v-if="user.admin" class="nav-item px-2 align-self-center fw-bold">
                        {{ user.username }} @parkease
                    </li>

                    <li class="nav-item px-2">
                        <button class="btn btn-danger" @click="logout">Sign Out</button>
                    </li>
                </ul>
                <ul v-else class="navbar-nav ms-auto px-2">
                    <li class="nav-item px-2">
                        <router-link class="nav-link" to="/register">Sign Up</router-link>
                    </li>
                    <li class="nav-item px-2">
                        <router-link class="nav-link" to="/login">Sign In</router-link>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>

<style scoped>
.nav-link {
    color: #dddddd
}

.nav-link:hover {
    color: #f0f0f0
}

.router-link-active.nav-link,
.router-link-exact-active.nav-link {
    color: var(--bs-warning);
    font-weight: 600;
}
</style>

<script>
import userMixin from '@/mixins/userMixin';
export default {
    name: 'NavBar',
    mixins: [userMixin],
};
</script>
