<template>
  <div id="navbar" class="navbar-box">
    <!-- <div class="navbar-slider" :style="{left:sliderPos+'px'}"></div> -->
    <ul>
      <li
        v-for="(item) in navList"
        :key="item.id"
        @click="cliickHandle(item.id)"
        :class="{'active':selectedBar==item.id}"
      >
        <!-- <router-link :to="item.name"> -->
        <router-link
          :to="item.id>1? (item.id<6? {name:'general', params:{id:item.name}}:{name:'list', params:{id:item.name}}):{name:item.name}"
        >
          <div v-html="item.svg" class="svg"></div>
          <span @mouseover="setPos" @mouseout="setPos">{{item.title}}</span>
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
      sliderPos: "30px",
      selectedBar: 1
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
    this.selectedBar = /*sessionStorage.getItem("selectedBar") || */ this.initSelectedBar();
  },
  methods: {
    initSelectedBar() {
      let path = this.$route.fullPath;
      // console.log("init", path);
      if (path.indexOf("home") != -1) return 1;
      else if (path.indexOf("bangumi") != -1) return 2;
      else if (path.indexOf("guoman") != -1) return 3;
      else if (path.indexOf("theater") != -1) return 4;
      else if (path.indexOf("filmtv") != -1) return 5;
      else if (path.indexOf("news") != -1) return 6;
      else if (path.indexOf("announce") != -1) return 7;
      else return 0;
    },

    cliickHandle(index) {
      this.selectedBar = index;
      // sessionStorage.setItem("selectedBar", index);
    },

    setPos(e) {
      //   let slider = document.getElementsByClassName("navbar-slider")[0];
      //   switch(e.type){
      //       case "mouseover":
      //           console.log(e.target);
      //           this.sliderPos = e.target.style.left;
      //           break;
      //       case "mouseout":
      //           this.sliderPos = '30px';
      //           break;
      //       default:
      //           break;
      //   }
      //   console.log(this.sliderPos);
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
  height: 50px;
  line-height: 50px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  ul {
    display: flex;
    justify-content: space-between;
    li {
      div.svg {
        display: inline-block;
      }

      span {
        position: relative;
        margin-left: 10px;
        top: -6px;
        font-size: 18px;
      }
    }

    li.active {
      color: #00a1d6;
      cursor: pointer;
      span::after {
        content: "";
        position: absolute;
        width: 50px;
        height: 3px;
        top: 40px;
        left: -6px;
        background: #00a1d6;
      }
    }

    li:hover {
      color: #00a1d6;
      cursor: pointer;
      span::after {
        content: "";
        position: absolute;
        width: 50px;
        height: 4px;
        top: 40px;
        left: -6px;
        background: #00a1d6;
      }
    }
  }

  .navbar-slider {
    position: absolute;
    top: 47px;
    left: 30px;
    width: 36px;
    height: 2px;
    background: #00a1d6;
  }
}
</style>