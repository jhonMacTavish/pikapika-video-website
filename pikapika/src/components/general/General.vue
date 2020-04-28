<template>
  <div class="page-content">
      <SearchBar/>
      <SearchBar/>
      <SearchBar/>
      <SearchBar/>
      <ShopWindow/>
  </div>
</template>

<script>
import SearchBar from '../common/searchBar/SearchBar'
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
  },
  watch:{
    '$route'(to,from){
      console.log(to, from);
    }
  },
  methods: {},
  components: {SearchBar,ShopWindow}
};
</script>

<style lang='less' scoped>
</style>
