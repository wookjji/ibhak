package com.teamp.cau.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.CacheControlHeadersWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
/*
 EnableGlobalMethodSecurity에 관한 설명들
 
prePostEnabled: @PreAuthorize 및 @PostAuthorize와 같은 pre/post 기능을 활성화합니다.
@PreAuthorize 어노테이션은 메서드 호출 전에 인증 및 권한 검사를 수행합니다. 예를 들어, 
@PreAuthorize("hasRole('ADMIN')") 어노테이션이 적용된 메서드는 현재 인증된 사용자가 
'ADMIN' 권한을 가지고 있을 때만 실행됩니다.

@PostAuthorize 어노테이션은 메서드 호출 후 결과를 검사하여 인증 및 권한 검사를 수행합니다.
예를 들어, @PostAuthorize("returnObject.userId == principal.username") 
어노테이션이 적용된 메서드는 실행 결과가 현재 인증된 사용자의 username과 일치할 때만 반환됩니다.

securedEnabled: @Secured 기능을 활성화합니다.
  @Secured 애너테이션은 권한이 부여된 역할(Role)을 기반으로 메서드 실행 권한을 결정합니다. 
  예를 들어, @Secured("ROLE_ADMIN")은 ADMIN 권한을 가진 사용자만 해당 메서드를 실행할 수 있도록 제한합니다. 
  메서드를 실행하려는 사용자가 해당 권한을 가지고 있지 않은 경우, AccessDeniedException 예외가 발생합니다.
	
	@Secured 애너테이션은 다른 스프링 시큐리티 애너테이션과 함께 사용할 수 있습니다. 예를 들어, 
	@Secured("ROLE_ADMIN")과 @PreAuthorize("hasRole('ADMIN')")은 동일한 기능을 수행합니다. 
	다만 @Secured는 메서드에 직접 적용하고, @PreAuthorize는 SpEL(Sping Expression Language) 표현식을 사용하여 권한을 결정합니다.

jsr250Enabled: JSR-250 보안 애노테이션을 사용할 수 있도록 지원합니다.
jsr250Enabled 설정이 활성화되면, @RolesAllowed 애노테이션을 사용하여 메서드나 클래스에 권한을 부여할 수 있습니다. 
@RolesAllowed 애노테이션은 해당 메서드나 클래스를 실행하려는 사용자가 지정된 권한을 가지고 있는지 검사하고,
권한이 없는 경우 AccessDeniedException 예외를 발생시킵니다.

예를 들어, @RolesAllowed("ADMIN") 애노테이션이 붙은 메서드는 ADMIN 권한을 가진 사용자만 호출할 수 있습니다. 
이와 같이 JSR-250 보안 애노테이션을 사용하면 별도의 보안 로직을 작성하지 않고도 간단하게 인가를 구현할 수 있습니다
 */

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true, jsr250Enabled = true)
public class SecurityConfig {
	 @Autowired
	    private UserDetailsServiceImpl UserDetailsServiceImpl;

	 // logger 객체 생성
    private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);
	
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // Use the UserDetailsServiceImp to authenticate users
        auth.userDetailsService(UserDetailsServiceImpl);
    }
   
    
    @Autowired
    private CustomLogoutHandler customLogoutHandler;
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {	
        // 권한에 따라 허용하는 url 설정
        // /login, /signup 페이지는 모두 허용, 다른 페이지는 인증된 사용자만 허용
    	http.csrf().disable();
        http
            .authorizeRequests()
//            	.antMatchers("/**").permitAll()
                .antMatchers("/main", "/findid" , "/findpass", "/resultid" ,"/resultpass" ,"/Admission","/Admission2" , "/payment","/pmss","/pms").permitAll()
                .antMatchers("/css/**","/js/**","/vendor/**" ,"/img/**" , "/images/**" , "/mapper/**").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/index/**").hasAnyRole("STUDENT","PROFESSOR","ADMIN")
                .anyRequest().authenticated();
		// login 설정
        http
            .formLogin()
                .loginPage("/main")    // GET 요청 (login form을 보여줌)
                .loginProcessingUrl("/auth")    // POST 요청 (login 창에 입력한 데이터를 처리)
                .usernameParameter("USER_ID")	// login에 필요한 id 값을 USER_ID로 설정 (default는 username)
                .passwordParameter("PSWD")	// login에 필요한 password 값을 PSWD(default)로 설정
               // .defaultSuccessUrl("/main" , true)	// login에 성공하면 /main(메인홈페이지)로 redirect
                .successHandler((request, response, authentication) -> {
                    logAuthorities(authentication);
                    response.sendRedirect("/main");
                });
        
	// 로그인 성공 후 권한 출력
        		
		// logout 설정
        http
            .logout()
                .logoutUrl("/logout")
				.invalidateHttpSession(true) // 로그아웃 시 세션 종료
				.clearAuthentication(true) // 로그아웃 시 권한 제거
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "POST")) // POST 방식으로만 로그아웃 가능하도록 설정
                .addLogoutHandler(customLogoutHandler) // 로그아웃 핸들러 등록
                .logoutSuccessUrl("/main")	// logout에 성공하면 /로 redirect
        		.deleteCookies("JSESSIONID"); // 쿠키 삭제

        http
        .sessionManagement()
            .invalidSessionUrl("/main") // 세션이 만료된 경우 이동할 페이지 지정
            .maximumSessions(1) // 최대 세션 수 지정
            .expiredUrl("/main"); // 세션이 만료된 경우 이동할 페이지 지정
            
     

        http
        .headers().cacheControl().disable() // 캐시 컨트롤 비활성화
        .addHeaderWriter(new CacheControlHeadersWriter());


        return http.build();
        
    }
    
    
 // filterChain 메소드 이후에 추가할 메소드
    @Bean
    public Object afterFilterChain() {
        return new Object() {
            @Autowired
            public void logAuthoritiesAfter(SecurityConfig config) {
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                config.logAuthorities(authentication);
            }
        };
    }

    // Authentication 객체를 이용하여 authorities 값을 가져와 로그로 출력하는 메소드
    private void logAuthorities(Authentication authentication) {
        if (authentication != null) {
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
            StringBuilder sb = new StringBuilder();
            for (GrantedAuthority authority : authorities) {
                sb.append(authority.getAuthority()).append(", ");
            }
            String authoritiesString = sb.length() > 0 ? sb.substring(0, sb.length() - 2) : "";
            logger.info("현재 사용자의 authorities: {}", authoritiesString);
        } else {
            logger.info("현재 사용자가 인증되지 않았습니다.");
        }
    }



 }
