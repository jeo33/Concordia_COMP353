<template>
  <div>
    <h1>Locations</h1>
    <ul>
      <li v-for="location in locations" :key="location.LocationID">
        <strong>{{ location.name }}</strong> - {{ location.city }}, {{ location.province }}
        <button @click="deleteLocation(location.location_id)">Delete</button>
      </li>
    </ul>

    <h2>Add Location</h2>
    <form @submit.prevent="addLocation">
      <label>
        Name:
        <input type="text" v-model="newLocation.name" />
      </label>
      <label>
        City:
        <input type="text" v-model="newLocation.city" />
      </label>
      <label>
        Province:
        <input type="text" v-model="newLocation.province" />
      </label>
      <label>
        Max Capacity:
        <input type="number" v-model="newLocation.max_capacity" />
      </label>
      <button type="submit">Add</button>
    </form>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  setup() {
    const locations = ref([]);
    const newLocation = ref({
      Name: "",
      City: "",
      Province: "",
      MaxCapacity: 0,
    });

    const fetchLocations = async () => {
      try {
        const response = await fetch("http://127.0.0.1:5000/locations");
        const data = await response.json();
        locations.value = data;
        console.log(data);
      } catch (error) {
        console.error("Failed to fetch locations", error);
      }
    };

    const addLocation = async () => {
      try {
        await fetch("http://127.0.0.1:5000/locations", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(newLocation.value),
        });
        await fetchLocations();
        newLocation.value = { Name: "", City: "", Province: "", MaxCapacity: 0 };
      } catch (error) {
        console.error("Failed to add location", error);
      }
    };

    const deleteLocation = async (id) => {
      try {
        await fetch(`http://127.0.0.1:5000/locations/${id}`, { method: "DELETE" });
        await fetchLocations();
      } catch (error) {
        console.error("Failed to delete location", error);
      }
    };

    onMounted(fetchLocations);

    return {
      locations,
      newLocation,
      addLocation,
      deleteLocation,
    };
  },
};
</script>
