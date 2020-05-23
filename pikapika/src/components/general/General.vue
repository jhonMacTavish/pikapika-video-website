<template>
  <div class="page-content">
      <!-- <SearchBar title="类型"/>
      <SearchBar title="季度"/>
      <SearchBar title="年份"/>
      <SearchBar title="首字母"/> -->
      <FilterBlock title="style"/>
      <FilterBlock v-if="path!='theater'" title="quarter"/>
      <FilterBlock v-else title="tag"/>
      <FilterBlock title="years"/>
      <FilterBlock title="initials"/>

      <ShopWindow/>
  </div>
</template>

<script>
// import SearchBar from '../common/searchBar/SearchBar'
import FilterBlock from "../common/filterBlock/FilterBlock";
import ShopWindow from '../common/shopWindow/ShopWindow'

export default {
  name: 'General',
  data() {
    return {
    };
  },
  mounted(){
    const returnEle = document.querySelector("#app"); //window是将要跳转区域的id
    if (!!returnEle) {
      returnEle.scrollIntoView(true); // true 是默认的
    }
  },
  computed:{
    path(){
      return this.$route.params.id;
    }
  },
  watch:{
    '$route'(to,from){
      this.$store.commit("UpdateSearchParams","reset");
    }
  },
  methods: {},
  components: {FilterBlock,ShopWindow}
};
</script>

<style lang='less' scoped>
</style>
