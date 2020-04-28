<template>
  <div class="searchBar-box">
    <FilterBlock />
  </div>
</template>

<script>
import FilterBlock from "../filterBlock/FilterBlock";

export default {
  name: "SearchBar",
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: { FilterBlock }
};
</script>

<style lang='less' scoped>
.searchBar-box {
  font-size: 12px;
}

.searchBar-box::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
