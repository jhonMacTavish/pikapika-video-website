<template>
  <div class="page-content">
    <Carousel />
    <Ad />
    <Block title="今日热播"/>
    <FanTimeTb/>
    <!-- <Block title="新番放送"/> -->
    <Block title="番组计划"/>
    <Block title="国产动漫"/>
    <Block title="剧场动画"/>
    <Block title="影视"/>
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