<template>
  <div class="searchBar-box">
    <FilterBlock />
  </div>
</template>

<script>
import FilterBlock from "../filterBlock/FilterBlock";

export default {
  name: "SearchBar",
  props:{
    title:''
  },
  data() {
    return {};
  },
  computed: {},
  watch: {
    // async '$route'(to,from){
    //   console.log("searchTo", to);
    // }
  },
  created(){
    console.log("routeSearch", this.$route);
  },
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
