#ifndef RESOURCE_HPP
#define RESOURCE_HPP

#include <string>
#include <map>
#include <memory>

template <class ResourceType>
class Resource
{
    public:
        template <class ResourceLoader>
        Resource(const std::string &p_path, ResourceLoader p_loader) : m_path(p_path)
        {
            if(!m_cache.Contains(m_path))
                m_cache.AddResource(m_path, p_loader(m_path));

            return;
        }

        template <class ResourceLoader>
        static void Load(const std::string &p_path, ResourceLoader p_loader)
        {
            if(!m_cache.Contains(p_path))
                m_cache.AddResource(p_path, p_loader(p_path));

            return;
        }

        ResourceType& Get() const
        {
            return m_cache.GetResource(m_path);
        }

    private:
        std::string m_path;

        class ResourceCache
        {
            public:
                void AddResource(const std::string &p_path, std::unique_ptr<ResourceType> p_resource)
                {
                    m_rmap[p_path] = std::move(p_resource);
                    return;
                }

                ResourceType& GetResource(const std::string &p_path) const
                {
                    return *(m_rmap.at(p_path));
                }

                bool Contains(const std::string &p_path) const
                {
                    return (m_rmap.end() != m_rmap.find(p_path));
                }
            private:
                std::map<std::string, std::unique_ptr<ResourceType>> m_rmap;
        };

        static ResourceCache m_cache;
};

template <class ResourceType>
typename Resource<ResourceType>::ResourceCache Resource<ResourceType>::m_cache;

#endif
