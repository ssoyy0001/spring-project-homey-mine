package org.homey.service;

import java.util.List;

import org.homey.domain.MemberVO;
import org.homey.domain.ScCriteria;
import org.homey.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
@Service
public class MemberServiceImpl implements MemberService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	@Override
	public List<MemberVO> list(ScCriteria cri) {
		return memberMapper.selectAll(cri);
	}

	@Override
	public MemberVO view(String mid) {
		
		return memberMapper.select(mid);
	}

	@Override
	public boolean modify(MemberVO mvo) {
		return memberMapper.update(mvo)==1;
	}

	@Override
	public boolean remove(String mid) {
		return memberMapper.delete(mid)==1;
	}

	@Override
	public boolean regist(MemberVO mvo) {
		return memberMapper.insert(mvo)==1;
	}

	@Override
	public String findId(String mname, String mphone) {
		return 	memberMapper.selectId(mname, mphone);
	}

	@Override
	public String findPw(String mid, String mname, String mphone) {
		return memberMapper.selectPw(mid, mname, mphone);
	}

	@Override
	public boolean modifyPw(String mid, String newpw) {
		return memberMapper.updatePw(mid, newpw)==1;
	}

	@Override
	public boolean chkId(String mid) {		
		return memberMapper.chkId(mid)==0;
	}

	@Override
	public int totalCount(ScCriteria cri) {
		return memberMapper.totalCount(cri);
	}


	
}
