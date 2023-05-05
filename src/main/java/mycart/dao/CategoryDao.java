package mycart.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import mycart.entities.Category;

public class CategoryDao {
	private SessionFactory factory;

	public CategoryDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	//save the category to database
	public int saveCategory(Category cat)
	{
		Session session = this.factory.openSession();
		Transaction tx = session.beginTransaction();
		int catId=(Integer) session.save(cat);
		tx.commit();
		session.close();
		return catId;
		
	}
	
	public List<Category> getCategories()
	{
		Session s=this.factory.openSession();
		Query query=s.createQuery("from Category");
		List<Category> list=query.list();
		return list;
	}
	
	public Category getCategoryById(int cid)
	{
		Category cat=null;
		try {
			
			Session session=this.factory.openSession();
			cat=session.get(Category.class, cid);
			session.close();
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cat;
	}
	

}
