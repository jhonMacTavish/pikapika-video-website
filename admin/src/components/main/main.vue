<template>
  <el-container style="height: 100vh; border: 1px solid #eee">
    <el-aside width="200px">
      <el-menu class="menu" router unique-opened :default-active="$route.path">
        <el-submenu index="1">
          <template slot="title">
            <i class="el-icon-film"></i>视频管理
          </template>
          <!-- <el-menu-item-group> -->
          <!-- <template slot="title">番剧</template> -->
          <el-menu-item index="/bangumi/list" class="menu-item">番剧</el-menu-item>
          <!-- <el-menu-item index="/bangumi/create">添加番剧</el-menu-item> -->
          <!-- </el-menu-item-group> -->
          <!-- <el-menu-item-group> -->
          <!-- <template slot="title">国漫</template> -->
          <el-menu-item index="/guoman/list" class="menu-item">国漫</el-menu-item>
          <!-- <el-menu-item index="/guoman/create">添加国漫</el-menu-item> -->
          <!-- </el-menu-item-group> -->
          <!-- <el-menu-item-group> -->
          <!-- <template slot="title">电影</template> -->
          <el-menu-item index="/theater/list" class="menu-item">电影</el-menu-item>
          <!-- <el-menu-item index="/theater/create">添加电影</el-menu-item> -->
          <!-- </el-menu-item-group> -->
          <!-- <el-menu-item-group> -->
          <!-- <template slot="title">影视</template> -->
          <el-menu-item index="/filmtv/list" class="menu-item">影视</el-menu-item>
          <!-- <el-menu-item index="/filmtv/create">添加影视</el-menu-item> -->
          <!-- </el-menu-item-group> -->
        </el-submenu>
        <el-submenu index="2">
          <template slot="title">
            <i class="el-icon-user"></i>用户管理
          </template>
          <!-- <el-menu-item-group> -->
          <!-- <template slot="title">番剧</template> -->
          <el-menu-item index="/userinfo/list" class="menu-item">用户信息</el-menu-item>
          <!-- <el-menu-item index="/bangumi/create">添加番剧</el-menu-item> -->
          <!-- </el-menu-item-group> -->
        </el-submenu>
      </el-menu>
    </el-aside>

    <el-container>
      <el-header style="text-align: right; font-size: 16px">
        <el-dropdown>
          <i class="el-icon-setting" style="margin-right: 15px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>退出</el-dropdown-item>
            <!-- <el-dropdown-item>新增</el-dropdown-item> -->
            <el-dropdown-item @click.native="$router.push('/')">返回首页</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        <span style="color:black">Dragon.Mr</span>
      </el-header>

      <el-main class="main-container">
        <keep-alive :exclude="cachedViews">
        <router-view></router-view>
        </keep-alive>
      </el-main>
    </el-container>
  </el-container>
</template>

<style>
.main-container {
  position: relative;
}

.close-button {
  position: absolute;
}

i {
  position: relative;
  top: -1px;
}

.el-header {
  background-color: #73c9e5;
  color: #333;
  line-height: 60px;
}

.el-aside {
  color: #333;
  background: url("../../../static/asideImg.png");
  background-position: center 100%;
  background-size: auto 520px;
  background-repeat: no-repeat;
}
</style>

<script>
export default {
  data() {
    return {
      // tableData: Array(20).fill(item),
      cachedViews: [
        "BangumiEdit",
        "GuomanEdit",
        "TheaterEdit",
        "FilmTVEdit",
        "UserinfoEdit"
      ]
    };
  }
};
</script>