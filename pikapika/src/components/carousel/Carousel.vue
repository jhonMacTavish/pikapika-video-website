<template>
  <div class="carousel-box">
    <el-carousel
      class="carousel-container"
      indicator-position="none"
      arrow="never"
      :interval="4000"
      height="332px"
      :autoplay="autoplay"
      @change="change"
      ref="carousel"
    >
      <el-carousel-item v-for="(item,index) in carousel" :key="item.id">
        <img :src="item.imgSrc" @click="handleClick(index)" />
      </el-carousel-item>
      <p ref="name" class="carousel-name"></p>
      <div class="carousel-indicator">
        <ul>
          <li
            v-for="(item,index) in carousel"
            :key="item.id"
            @mouseenter="setCurrentIndex(index)"
            @mouseleave="setAutoplay"
            @click="handleClick(index)"
          >
            <img :src="item.imgSrc"/>
          </li>
        </ul>
        <div class="sliderBox" ref="sliderBox" @click="handleClick(selectIndex)"></div>
      </div>
    </el-carousel>
  </div>
</template>

<script>
export default {
  name: "Carousel",
  data() {
    return {
      carousel: [
        // {
        //   id: 1,
        //   imgSrc: "@/../static/imgs/lunbotu/1.jpg",
        //   name:
        //     "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
        // },
        // {
        //   id: 2,
        //   imgSrc: "@/../static/imgs/lunbotu/2.jpg",
        //   name: "222222222222"
        // },
        // {
        //   id: 3,
        //   imgSrc: "@/../static/imgs/lunbotu/3.jpg",
        //   name: "333333333333"
        // },
        // {
        //   id: 4,
        //   imgSrc: "@/../static/imgs/lunbotu/4.jpg",
        //   name: "555555555555"
        // },
        // {
        //   id: 5,
        //   imgSrc: "@/../static/imgs/lunbotu/5.jpg",
        //   name: "555555555555"
        // }
      ],
      autoplay: true,
      oldPosition: 0,
      selectIndex: 0
    };
  },
  async created() {
    await this.fetch();
  },
  methods: {
    async fetch() {
      const res = await this.$http.get("/carousels");
      this.carousel = res.data.list;
      this.$refs.name.innerHTML = this.carousel[0].name;
    },

    setCurrentIndex(index) {
      this.$refs.carousel.setActiveItem(index);
      this.autoplay = false;
      this.selectIndex = index;
    },

    setAutoplay() {
      this.autoplay = true;
    },

    change(current, prev) {
      this.$refs.sliderBox.style.left = `${current * 81}px`;
      this.$refs.name.innerHTML = this.carousel[current].name;
    },

    async handleClick(index) {
      console.log("handleClick", index);
      let { type_id, film_id } = this.carousel[index];
      let episode = this.carousel[index].episode;
      this.$store.commit("UpdateVideoParams", { type_id, film_id });
      let params = {};
      params.type_id = type_id;
      params.film_id = film_id;
      //console.log("params", params);

      switch (params.type_id) {
        case "1":
          await this.getFaninfo("/bangumis", params);
          break;
        case "2":
          await this.getFaninfo("/guomans", params);
          break;
        default:
          break;
      }

      let routerUrl = this.$router.resolve({
        path: `/playinfo/play/${type_id}/${film_id}/${episode}`
      });
      window.open(routerUrl.href, "_blank");
      let res = await this.$http.put("volumes", { params });
    },

    async getFaninfo(path, params) {
      let res = await this.$http.get(`${path}/${params.film_id}`);
      // //console.log("objinfo", res.data[0]);
      this.objectInfo = res.data[0];
      this.getRate();

      this.$store.commit("UpdateObjectInfo", this.objectInfo);

      res = await this.$http.get("/videos", { params });
      // //console.log("res", res.data.list);
      this.$store.commit("UpdateEpisodeList", res.data.list);
    }
  }
};
</script>

<style lang="less" scoped>
::-webkit-scrollbar {
  width: 0 !important;
}
.carousel-container {
  overflow-y: hidden;
  position: relative;
  border-radius: 5px;
  // background: rgba(0, 0, 0, 0.1);
  cursor: pointer;
  .carousel-name {
    position: absolute;
    max-width: 500px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    z-index: 999;
    color: white;
    bottom: 8px;
    left: 10px;
  }

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
          z-index: 2020;
          display: inline-block;
          padding: 2.5px;
          width: 66px;
          height: 50px;
          border-radius: 4px;
          background: white;
          overflow: auto;
        }

        // img:hover {
        //   background: #f25d8e;
        // }
      }
    }

    .sliderBox {
      position: absolute;
      top: 0px;
      left: 0px;
      display: inline-block;
      width: 65.5px;
      height: 49px;
      border-radius: 4px;
      border: 3px solid #39c5bb;
      transition-duration: 0.3s;
      transition-timing-function: ease-out;
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
  height: 70px;
  background: linear-gradient(-180deg, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75));
  cursor: auto;
}
</style>