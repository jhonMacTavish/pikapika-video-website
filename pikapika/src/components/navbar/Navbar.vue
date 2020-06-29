<template>
  <div id="navbar" class="navbar-box">
    <!-- <div class="navbar-slider" :style="{left:sliderPos+'px'}"></div> -->
    <ul>
      <li
        v-for="(item) in navList"
        :key="item.id"
        @mouseenter="enter(item.id)"
        @mouseleave="leave()"
        @click="cliickHandle(item.id)"
      >
        <!-- <router-link :to="item.name"> -->
        <router-link
          class="navitem"
          :to="item.id>1? (item.id<6? {name:'general', params:{id:item.name}}:{name:'list', params:{id:item.name}}):{name:item.name}"
        >
          <img :src="item.icon" class="icon" />
          <!-- <div v-else v-html="item.svg"></div> -->
          <div>
            <span :class="{'active':selectedBar==item.id}">{{item.title}}</span>
          </div>
        </router-link>
      </li>
    </ul>
    <div class="slider" ref="slider" @mouseenter="enter(index)" @mouseleave="leave()"></div>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
      sliderPos: "30px",
      selectedBar: 1,
      index: 1,
      oldPosition: 83
    };
  },
  computed: {
    navList() {
      return this.$store.getters.navList;
    }
  },
  watch: {
    $route(to, from) {
      this.selectedBar = this.initSelectedBar();
    }
  },
  created() {
    this.selectedBar =  this.initSelectedBar();
    // if()
    this.oldPosition = 83 + (this.selectedBar - 1) * 166;
  },

  mounted(){
    this.$refs.slider.style.left = `${this.oldPosition}px`;
  },
  methods: {
    initSelectedBar() {
      let path = this.$route.fullPath;
      // //console.log("init", path);
      if (path.indexOf("home") != -1) return 1;
      else if (path.indexOf("bangumi") != -1 || path.indexOf("type_id=1") != -1) return 2;
      else if (path.indexOf("guoman") != -1 || path.indexOf("type_id=2") != -1) return 3;
      else if (path.indexOf("theater") != -1 || path.indexOf("type_id=3") != -1) return 4;
      else if (path.indexOf("filmtv") != -1 || path.indexOf("type_id=4") != -1) return 5;
      else if (path.indexOf("news") != -1) return 6;
      else if (path.indexOf("announce") != -1) return 7;
      else return 1;
    },

    cliickHandle(index) {
      this.selectedBar = index;
      this.oldPosition = 83 + (this.selectedBar - 1) * 166;
    },

    enter(index) {
      let postiion = 83 + (index - 1) * 166;
      this.$refs.slider.style.left = `${postiion}px`;
    },

    leave() {
      this.$refs.slider.style.left = `${this.oldPosition}px`;
    }
  }
};
</script>

<style lang="less" scoped>
.navbar-box {
  position: relative;
  margin: 0 auto;
  width: 1160px;
  margin-top: 10px;
  // padding-bottom: 1px;
  ul {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    li {
      // width: 100%;
      .navitem {
        display: inline-block;
        // background: aquamarine;
        text-align: center;
        width: 166px;
        padding-top: 4px;
        padding-bottom: 6px;
        // background: blanchedalmond;
        div {
          display: inline-block;
          span {
            position: relative;
            display: inline-block;
            top: -6px;
            height: 20px;
            line-height: 20px;
            font-size: 18px;
          }

          span.active {
            color: #39c5bb;
          }
        }

        img.icon {
          display: inline-block;
          // background: brown;
          margin-right: 8px;
          width: 30px;
          height: 30px;
        }
      }

      .navitem:hover {
        color: #39c5bb;
      }
    }

    li:hover {
      cursor: pointer;
    }
  }

  .slider {
    position: absolute;
    top: 41.5px;
    left: 81px;
    // position: relative;
    z-index: -1;
    // // top: 42.5px;
    // left: 81px;
    width: 46px;
    height: 2.5px;
    background: #39c5bb;
    transition-duration: 0.3s;
    transition-timing-function: ease-out;
  }
}
</style>