<template>
  <div class="page-content">
    <Carousel />
    <Ad />
    <!-- <Block title="今日热播"/> -->
    <FanTimeTb/>
    <!-- <Block title="新番放送"/> -->
    <Block title="番剧"/>
    <Block title="国漫"/>
    <Block title="电影"/>
    <Block title="剧集"/>
  </div>
</template>

<script>
import Carousel from "../carousel/Carousel";
import Ad from "../ad/Ad";
import Block from "../block/Block";
import FanTimeTb from "../fanTimeTb/FanTimeTb";

export default {
  name: "Home",
  data() {
    return {};
  },
  components: { Carousel, Ad, Block, FanTimeTb }
};
</script>

<style scoped>
</style>