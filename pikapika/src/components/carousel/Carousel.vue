<template>
  <div class="carousel-box">
    <el-carousel
      class="carousel-container"
      indicator-position="none"
      arrow="never"
      :interval="4000"
      height="332px"
      :autoplay="autoplay"
      ref="carousel"
    >
      <el-carousel-item v-for="item in imgs" :key="item.id">
        <!-- <img :src="item.imgSrc" alt @click="$router.push({name: 'faninfo'})" /> -->
        <img :src="item.imgSrc" alt @click="$router.push({name: 'faninfo',query:{t_id:1,v_id:item.id}})" />

      </el-carousel-item>
      <div class="carousel-indicator">
        <ul>
          <li
            v-for="item in imgs"
            :key="item.id"
            @mouseenter="setCurrentIndex(item.id)"
            @mouseleave="setAutoplay"
          >
            <img :src="item.imgSrc" alt />
          </li>
        </ul>
      </div>
    </el-carousel>
  </div>
</template>

<script>
export default {
  name: "Carousel",
  data() {
    return {
      imgs: [
        {
          id: 1,
          imgSrc: "@/../static/imgs/lunbotu/1.jpg"
        },
        {
          id: 2,
          imgSrc: "@/../static/imgs/lunbotu/2.jpg"
        },
        {
          id: 3,
          imgSrc: "@/../static/imgs/lunbotu/3.jpg"
        },
        {
          id: 4,
          imgSrc: "@/../static/imgs/lunbotu/4.jpg"
        },
        {
          id: 5,
          imgSrc: "@/../static/imgs/lunbotu/5.jpg"
        }
      ],
      autoplay: true
    };
  },
  methods: {
    setCurrentIndex(index) {
      this.$refs.carousel.setActiveItem(index - 1);
      this.autoplay = false;
    },

    setAutoplay() {
      this.autoplay = true;
    }
  }
};
</script>

<style lang="less" scoped>
.carousel-container {
  position: relative;
  border-radius: 5px;
  // background: rgba(0, 0, 0, 0.1);
  cursor: pointer;

  .carousel-indicator {
    position: absolute;
    z-index: 999;
    bottom: 5px;
    right: 0;
    ul {
      display: flex;
      cursor: auto;
      li {
        margin-right: 10px;
        img {
          display: inline-block;
          padding: 1.5px;
          width: 64px;
          height: 48px;
          border-radius: 4px;
          background: white;
          overflow: auto;
          cursor: pointer;
        }

        img:hover {
          background: #f25d8e;
        }
      }
    }
  }
}

.carousel-container::after {
  content: "";
  position: absolute;
  z-index: 99;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 62px;
  background: linear-gradient(-180deg, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75));
  cursor:auto;
}
</style>